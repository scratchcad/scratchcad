import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { ApiError } from "./api/errors";
import { type FileEntry, fileUrl, readExport, readScript, writeFile } from "./api/files";
import { exportShape } from "./api/scratchcad";
import { Drawer } from "./components/Drawer";
import { ExportPanel } from "./components/ExportPanel";
import { FileList } from "./components/FileList";
import { ParamsPanel } from "./components/ParamsPanel";
import { ProblemsPanel } from "./components/ProblemsPanel";
import { CodeEditor } from "./editor/CodeEditor";
import { useFiles, usePreview } from "./hooks";
import { type Format, FORMAT_INFO } from "../../src/shared/formats.ts";
import { parseParams, setParam, stableRanges } from "../../src/shared/params.ts";
import { EXPORT_DETAIL, PREVIEW_DETAIL, toleranceFor } from "./lib/detail";
import { NEW_SCRIPT } from "./lib/template";
import type { MeshInfo } from "./viewport/Viewport";
import { ViewportView } from "./viewport/ViewportView";

type Open =
  | { kind: "script"; path: string; version: string; saved: string }
  | { kind: "mesh"; path: string; version: string; stl: ArrayBuffer };

/** A button or download link on a notice. */
interface Action {
  label: string;
  href?: string;
  onClick?: () => void;
}

interface Notice {
  id: number;
  tone: "info" | "error";
  text: string;
  action?: Action;
}

/** The file changed on disk while there were unsaved edits (or a save hit 409). */
interface Conflict {
  /** The version on disk now, or null if the file was deleted. */
  version: string | null;
}

const message = (e: unknown) =>
  e instanceof ApiError ? `${e.code}: ${e.message}` : e instanceof Error ? e.message : String(e);

export default function App() {
  const [open, setOpen] = useState<Open | null>(null);
  const [text, setText] = useState("");
  const [conflict, setConflict] = useState<Conflict | null>(null);
  const [notices, setNotices] = useState<Notice[]>([]);
  // The file list slides out over the part; it's open until a file is picked.
  const [drawer, setDrawer] = useState<"files" | null>("files");
  // The right-hand panel shows the sliders, or the script in their place.
  const [panel, setPanel] = useState<"sliders" | "script">("sliders");
  const [previewDetail, setPreviewDetail] = useState(PREVIEW_DETAIL);
  const [exportDetail, setExportDetail] = useState(EXPORT_DETAIL);
  const [exportFormat, setExportFormat] = useState<Format>("stl");
  const [exporting, setExporting] = useState(false);
  // Where the script editor should put the cursor when it next opens.
  const [reveal, setReveal] = useState<{ line: number; column: number; key: number } | null>(null);
  const [meshInfo, setMeshInfo] = useState<MeshInfo | null>(null);
  // Versions of the open file this editor has loaded or written, so a poll
  // that raced with a save isn't mistaken for someone else's change.
  const seen = useRef(new Set<string>());
  // Whether a listing has shown the open file yet. Until then, its absence
  // means the listing predates the file (a new script), not a deletion.
  const listed = useRef(false);

  const script = open?.kind === "script" ? text : null;
  const dirty = open?.kind === "script" && text !== open.saved;
  const preview = usePreview(open?.path ?? null, script, previewDetail);
  const saved = open?.kind === "script" ? open.saved : null;
  // Ranges guessed for parameters without one come from the saved script, so
  // they stay put (and the slider thumb moves) while the value is dragged.
  const baseline = useMemo(() => (saved === null ? [] : parseParams(saved)), [saved]);
  const params = useMemo(
    () => (script === null ? [] : stableRanges(parseParams(script), baseline)),
    [script, baseline],
  );
  const errors = preview.problems.filter((p) => p.severity === "error");

  const notify = useCallback((tone: Notice["tone"], text: string, action?: Action) => {
    const id = Date.now() + Math.random();
    setNotices((n) => [...n, { id, tone, text, action }]);
    setTimeout(
      () => setNotices((n) => n.filter((x) => x.id !== id)),
      tone === "error" || action ? 8000 : 4000,
    );
  }, []);

  const load = useCallback(
    async (file: Pick<FileEntry, "path" | "kind"> & Partial<FileEntry>) => {
      try {
        if (file.kind === "script") {
          const { text, version } = await readScript(file.path);
          seen.current = new Set([version]);
          listed.current = false;
          setOpen({ kind: "script", path: file.path, version, saved: text });
          setText(text);
        } else if (file.format !== undefined && file.format !== "stl") {
          // Only STL meshes can be shown; the file list offers the rest as downloads.
          notify("error", `${file.path} can't be shown here; download it from Files instead.`);
          return false;
        } else {
          const stl = await readExport(file.path);
          const version = file.version ?? "";
          seen.current = new Set([version]);
          listed.current = false;
          setOpen({ kind: "mesh", path: file.path, version, stl });
        }
        setConflict(null);
        return true;
      } catch (e) {
        notify("error", `Could not open ${file.path}: ${message(e)}`);
        return false;
      }
    },
    [notify],
  );

  // Keep ?open= in step with the open file, so reloading the page keeps it.
  const openPath = open?.path ?? null;
  useEffect(() => {
    const url = new URL(window.location.href);
    if (openPath) url.searchParams.set("open", openPath);
    else url.searchParams.delete("open");
    window.history.replaceState(null, "", url);
  }, [openPath]);

  /** Opens a file the user picked, and puts the file list away. */
  const openFile = async (file: FileEntry) => {
    if (file.path === open?.path) return setDrawer(null);
    if (dirty && !window.confirm(`Discard unsaved changes to ${open.path}?`)) return;
    if (await load(file)) setDrawer((d) => (d === "files" ? null : d));
  };

  // React to changes on disk, usually the agent rewriting a script. The
  // handler reads the latest state through a ref, as polling outlives renders.
  const latest = useRef({ open, dirty, load, notify });
  useEffect(() => {
    latest.current = { open, dirty, load, notify };
  });
  // The file named in ?open= (save_script's editor link), opened once the
  // first listing arrives.
  const linked = useRef<string | null>(new URLSearchParams(window.location.search).get("open"));
  const onFiles = useCallback((listing: FileEntry[]) => {
    const { open, dirty, load, notify } = latest.current;
    if (linked.current !== null) {
      const wanted = listing.find((f) => f.path === linked.current);
      if (wanted) {
        void load(wanted).then((ok) => ok && setDrawer((d) => (d === "files" ? null : d)));
      } else {
        notify("error", `${linked.current} isn't in the output directory.`);
      }
      linked.current = null;
      return;
    }
    if (!open) return;
    const entry = listing.find((f) => f.path === open.path);
    if (!entry) {
      if (listed.current) setConflict({ version: null });
      return;
    }
    listed.current = true;
    if (seen.current.has(entry.version)) return;
    seen.current.add(entry.version);
    if (open.kind === "script" && dirty) {
      setConflict({ version: entry.version });
    } else {
      notify("info", `Reloaded ${open.path}: it changed on disk.`);
      void load(entry);
    }
  }, []);
  const { files, error: filesError, refresh } = useFiles(onFiles);

  const save = useCallback(async () => {
    if (open?.kind !== "script") return;
    try {
      const entry = await writeFile(open.path, text, open.version);
      seen.current.add(entry.version);
      setOpen({ ...open, version: entry.version, saved: text });
      setConflict(null);
      refresh();
    } catch (e) {
      if (e instanceof ApiError && e.status === 409) {
        setConflict({ version: e.current ?? null });
        notify("error", `Not saved: ${open.path} changed on disk. Choose which version to keep.`);
      } else {
        notify("error", `Could not save ${open.path}: ${message(e)}`);
      }
    }
  }, [open, text, notify, refresh]);

  const keepMine = () => {
    if (open?.kind !== "script" || !conflict) return;
    const version = conflict.version ?? "new";
    seen.current.add(version);
    setOpen({ ...open, version });
    setConflict(null);
  };

  const newScript = async () => {
    if (dirty && !window.confirm(`Discard unsaved changes to ${open.path}?`)) return;
    let name = window.prompt("Name of the new script", "part.rhai")?.trim();
    if (!name) return;
    if (!name.toLowerCase().endsWith(".rhai")) name += ".rhai";
    try {
      await writeFile(name, NEW_SCRIPT, "new");
      refresh();
      if (await load({ path: name, kind: "script" })) setDrawer(null);
    } catch (e) {
      notify("error", `Could not create ${name}: ${message(e)}`);
    }
  };

  /** Writes the script's shape next to it, in the chosen format. */
  const exportPart = async () => {
    if (open?.kind !== "script") return;
    const info = FORMAT_INFO[exportFormat];
    const path = open.path.replace(/\.rhai$/i, "") + info.extensions[0];
    const exists = files?.some((f) => f.path === path) ?? false;
    if (exists && !window.confirm(`Replace ${path}?`)) return;
    setExporting(true);
    try {
      // Mesh detail is relative to the size of the part the preview last built.
      const size = preview.shape?.bounding_box.size ?? null;
      const tolerance = info.mesh ? toleranceFor(exportDetail, size) : undefined;
      const result = await exportShape(exportFormat, { script: text, tolerance });
      const entry = await writeFile(path, result.data, exists ? null : "new");
      refresh();
      const triangles =
        result.triangles === null ? "" : ` (${result.triangles.toLocaleString()} triangles)`;
      // STL files show here; the other formats are for other programs.
      const action: Action =
        exportFormat === "stl"
          ? { label: "Show", onClick: () => void openFile(entry) }
          : { label: "Download", href: fileUrl(path) };
      notify("info", `Exported ${path}${triangles}.`, action);
      for (const warning of result.warnings) notify("error", `Warning: ${warning}`);
    } catch (e) {
      notify("error", `Export failed: ${message(e)}`);
    } finally {
      setExporting(false);
    }
  };

  // Ctrl/Cmd+S saves, and closing the tab warns about unsaved edits.
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === "s") {
        e.preventDefault();
        void save();
      }
    };
    const onUnload = (e: BeforeUnloadEvent) => {
      if (dirty) e.preventDefault();
    };
    window.addEventListener("keydown", onKey);
    window.addEventListener("beforeunload", onUnload);
    return () => {
      window.removeEventListener("keydown", onKey);
      window.removeEventListener("beforeunload", onUnload);
    };
  }, [save, dirty]);

  const stl = open?.kind === "mesh" ? open.stl : preview.stl;
  const sourceScript =
    open?.kind === "mesh"
      ? files?.find((f) => f.path === open.path.replace(/\.stl$/i, "") + ".rhai")
      : undefined;
  const closeDrawer = useCallback(() => setDrawer(null), []);
  const showScript = (show: boolean) => setPanel(show ? "script" : "sliders");
  const scriptShown = panel === "script" && open?.kind === "script";
  const button =
    "rounded-md border border-zinc-300 px-3 py-1 text-sm font-medium whitespace-nowrap " +
    "hover:bg-zinc-100 disabled:cursor-not-allowed disabled:opacity-50 dark:border-zinc-700 dark:hover:bg-zinc-800";
  const primary =
    "rounded-md border border-blue-600 bg-blue-600 px-3 py-1 text-sm font-medium whitespace-nowrap text-white " +
    "hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-50";
  const pressed =
    "aria-pressed:border-blue-500 aria-pressed:text-blue-600 dark:aria-pressed:text-blue-400";

  return (
    <div className="flex h-full flex-col">
      <header className="flex items-center gap-2 border-b border-zinc-200 bg-white px-3 py-2 dark:border-zinc-800 dark:bg-zinc-900">
        <button
          type="button"
          aria-pressed={drawer === "files"}
          onClick={() => setDrawer((d) => (d ? null : "files"))}
          className={`${button} ${pressed}`}
        >
          ☰ Files
        </button>
        <h1 className="ml-1 hidden font-semibold sm:block">scratchcad</h1>
        <span className="min-w-0 truncate text-sm text-zinc-500">
          {open ? open.path : "No file open"}
          {dirty && <span title="Unsaved changes"> ●</span>}
        </span>
        <div className="ml-auto flex shrink-0 gap-1.5 sm:gap-2">
          <button
            type="button"
            aria-pressed={scriptShown}
            disabled={open?.kind !== "script"}
            onClick={() => showScript(!scriptShown)}
            className={`${button} ${pressed} relative`}
            title={scriptShown ? "Back to the sliders" : "Show the script, to edit it by hand"}
          >
            {"</>"} Script
            {errors.length > 0 && (
              <span
                aria-label={`${errors.length} error${errors.length > 1 ? "s" : ""}`}
                className="absolute -top-1.5 -right-1.5 h-3 w-3 rounded-full border-2 border-white bg-red-500 dark:border-zinc-900"
              />
            )}
          </button>
          <button
            type="button"
            className={dirty ? primary : button}
            disabled={!dirty}
            onClick={() => void save()}
            title="Save (Ctrl+S)"
          >
            Save
          </button>
          <button
            type="button"
            className={button}
            disabled={open?.kind !== "script" || exporting}
            onClick={() => void exportPart()}
            title={`Write ${FORMAT_INFO[exportFormat].use} next to the script (change the format under Detail & export)`}
          >
            {exporting ? "Exporting…" : `Export ${FORMAT_INFO[exportFormat].label}`}
          </button>
        </div>
      </header>

      {conflict && open?.kind === "script" && (
        <div
          role="alert"
          className="flex flex-wrap items-center gap-2 border-b border-amber-300 bg-amber-50 px-3 py-2 text-sm text-amber-900 dark:border-amber-800 dark:bg-amber-950 dark:text-amber-200"
        >
          <span className="mr-auto">
            {conflict.version
              ? `${open.path} changed on disk (perhaps the agent edited it) while you had unsaved changes.`
              : `${open.path} was deleted on disk.`}
          </span>
          {conflict.version && (
            <button type="button" className={button} onClick={() => void load(open)}>
              Load the version on disk
            </button>
          )}
          <button type="button" className={button} onClick={keepMine}>
            {conflict.version ? "Keep mine (overwrite on save)" : "Keep mine (recreate on save)"}
          </button>
        </div>
      )}

      <div className="flex min-h-0 flex-1 flex-col lg:flex-row">
        <main className="relative min-h-[55vh] min-w-0 overflow-hidden lg:min-h-0 lg:flex-[2]">
          <ViewportView
            stl={stl}
            fitKey={open?.path ?? null}
            stale={open?.kind === "script" && preview.stale}
            busy={preview.running}
            info={meshInfo}
            onInfo={setMeshInfo}
            onError={(text) => notify("error", text)}
          />
          {!open && (
            <div className="pointer-events-none absolute inset-0 flex items-center justify-center p-8">
              <p className="max-w-sm text-center text-sm leading-relaxed text-zinc-500">
                Pick a part from <strong>Files</strong>. Scripts the agent saves show up there, and
                update here when it changes them.
              </p>
            </div>
          )}

          <Drawer
            open={drawer === "files"}
            onClose={closeDrawer}
            title="Files"
            width="w-80"
            modal
            actions={
              <button
                type="button"
                onClick={() => void newScript()}
                className="rounded-md bg-blue-600 px-2 py-0.5 text-xs font-medium text-white hover:bg-blue-700"
              >
                New script
              </button>
            }
          >
            <FileList
              files={files}
              error={filesError}
              openPath={open?.path ?? null}
              onOpen={(file) => void openFile(file)}
            />
          </Drawer>
        </main>

        <aside className="flex min-h-0 min-w-0 flex-col border-t border-zinc-200 bg-white lg:flex-1 lg:border-t-0 lg:border-l dark:border-zinc-800 dark:bg-zinc-900">
          {open?.kind === "script" && (
            // Kept mounted while the sliders show, so its undo history survives.
            <div className={`min-h-0 flex-1 flex-col ${scriptShown ? "flex" : "hidden"}`}>
              <div className="flex items-center gap-2 border-b border-zinc-200 px-3 py-2 dark:border-zinc-800">
                <h2 className="text-sm font-semibold">Script</h2>
                <button
                  type="button"
                  onClick={() => showScript(false)}
                  className="ml-auto text-xs font-medium text-blue-600 hover:underline dark:text-blue-400"
                >
                  Back to the sliders
                </button>
              </div>
              <div className="min-h-0 flex-1">
                <CodeEditor
                  docKey={open.path}
                  value={text}
                  onChange={setText}
                  problems={preview.problems}
                  reveal={reveal}
                  visible={scriptShown}
                />
              </div>
              <ProblemsPanel
                problems={preview.problems}
                shape={preview.shape}
                computeMs={preview.computeMs}
                running={preview.running}
              />
            </div>
          )}
          {open?.kind === "script" ? (
            <div
              className={`min-h-0 flex-1 flex-col overflow-y-auto ${scriptShown ? "hidden" : "flex"}`}
            >
              {errors.length > 0 && (
                <div
                  role="alert"
                  className="m-3 mb-0 rounded-md bg-red-50 px-3 py-2 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
                >
                  <p className="font-medium">The part can't be built.</p>
                  <p className="mt-0.5 font-mono text-xs break-words">{errors[0]!.message}</p>
                  <button
                    type="button"
                    onClick={() => {
                      showScript(true);
                      const { line, column } = errors[0]!;
                      if (line !== undefined)
                        setReveal({ line, column: column ?? 1, key: Date.now() });
                    }}
                    className="mt-1.5 text-xs font-medium underline"
                  >
                    Show in the script
                  </button>
                </div>
              )}
              <section className="p-4">
                <div className="mb-4 flex items-baseline justify-between gap-2">
                  <h2 className="text-sm font-semibold">Parameters</h2>
                  {dirty && (
                    <button
                      type="button"
                      onClick={() => setText(open.saved)}
                      className="text-xs text-zinc-500 underline hover:text-zinc-900 dark:hover:text-zinc-100"
                    >
                      Undo all changes
                    </button>
                  )}
                </div>
                <ParamsPanel
                  params={params}
                  onChange={(param, value) => setText((t) => setParam(t, param, value))}
                />
              </section>
              <details className="mt-auto border-t border-zinc-200 dark:border-zinc-800">
                <summary className="cursor-pointer px-4 py-3 text-sm font-semibold select-none">
                  Detail & export
                </summary>
                <div className="px-4 pb-4">
                  <ExportPanel
                    previewDetail={previewDetail}
                    exportDetail={exportDetail}
                    format={exportFormat}
                    onPreviewDetail={setPreviewDetail}
                    onExportDetail={setExportDetail}
                    onFormat={setExportFormat}
                  />
                </div>
              </details>
            </div>
          ) : (
            <div className="flex flex-1 flex-col items-center justify-center gap-3 p-6 text-center text-sm text-zinc-500">
              {open?.kind === "mesh" ? (
                <>
                  <p>{open.path} is an exported mesh, so it has no parameters to change.</p>
                  {sourceScript && (
                    <button
                      type="button"
                      className={button}
                      onClick={() => void openFile(sourceScript)}
                    >
                      Open {sourceScript.path}
                    </button>
                  )}
                </>
              ) : (
                <p>The sliders for a part's dimensions appear here once it's open.</p>
              )}
            </div>
          )}
        </aside>
      </div>

      <div className="pointer-events-none fixed right-4 bottom-4 z-40 flex w-96 max-w-[calc(100vw-2rem)] flex-col gap-2">
        {notices.map((n) => (
          <div
            key={n.id}
            role="status"
            className={`pointer-events-auto rounded-md px-3 py-2 text-sm shadow-lg ${
              n.tone === "error"
                ? "bg-red-600 text-white"
                : "bg-zinc-900 text-white dark:bg-zinc-100 dark:text-zinc-900"
            }`}
          >
            {n.text}
            {n.action &&
              (n.action.href ? (
                <a href={n.action.href} download className="ml-2 font-medium underline">
                  {n.action.label}
                </a>
              ) : (
                <button
                  type="button"
                  onClick={n.action.onClick}
                  className="ml-2 font-medium underline"
                >
                  {n.action.label}
                </button>
              ))}
          </div>
        ))}
      </div>
    </div>
  );
}
