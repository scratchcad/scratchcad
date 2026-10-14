import { type Format, FORMAT_INFO, FORMATS } from "../../../src/shared/formats.ts";
import { DETAILS } from "../lib/detail";

interface Props {
  previewDetail: number;
  exportDetail: number;
  format: Format;
  onPreviewDetail: (detail: number) => void;
  onExportDetail: (detail: number) => void;
  onFormat: (format: Format) => void;
}

const select =
  "rounded border border-zinc-300 bg-white px-1 py-0.5 text-xs disabled:opacity-50 " +
  "dark:border-zinc-700 dark:bg-zinc-950";

function DetailSelect({
  label,
  value,
  disabled = false,
  onChange,
}: {
  label: string;
  value: number;
  disabled?: boolean;
  onChange: (detail: number) => void;
}) {
  return (
    <label className="flex items-center justify-between gap-2 text-xs">
      {label}
      <select
        value={value}
        disabled={disabled}
        onChange={(e) => onChange(Number(e.target.value))}
        className={select}
      >
        {DETAILS.map((d, i) => (
          <option key={d.label} value={i}>
            {d.label} (1/{Math.round(1 / d.fraction).toLocaleString()} of size)
          </option>
        ))}
      </select>
    </label>
  );
}

/** Mesh detail for the preview and exports, and the format exports are written in. */
export function ExportPanel(props: Props) {
  const mesh = FORMAT_INFO[props.format].mesh;
  return (
    <div className="flex flex-col gap-3">
      <p className="text-xs leading-relaxed text-zinc-500">
        Detail is how closely a mesh follows the part's curved surfaces, as a fraction of the part's
        size. STEP, IGES and BREP keep the exact geometry, so they have none.
      </p>
      <DetailSelect
        label="Preview detail"
        value={props.previewDetail}
        onChange={props.onPreviewDetail}
      />
      <div className="flex flex-col gap-1.5 border-t border-zinc-200 pt-3 dark:border-zinc-800">
        <label className="flex items-center justify-between gap-2 text-xs">
          Export format
          <select
            value={props.format}
            onChange={(e) => props.onFormat(e.target.value as Format)}
            className={select}
          >
            {FORMATS.map((f) => (
              <option key={f} value={f}>
                {FORMAT_INFO[f].label}: {FORMAT_INFO[f].use}
              </option>
            ))}
          </select>
        </label>
        <DetailSelect
          label="Export detail"
          value={props.exportDetail}
          disabled={!mesh}
          onChange={props.onExportDetail}
        />
      </div>
    </div>
  );
}
