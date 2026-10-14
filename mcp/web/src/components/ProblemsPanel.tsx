import type { ShapeSummary } from "../api/scratchcad";
import type { Problem } from "../lib/problems";

interface Props {
  problems: Problem[];
  shape: ShapeSummary | null;
  computeMs: number | null;
  running: boolean;
}

const fmt = (n: number) => Number(n.toPrecision(4)).toLocaleString();

/** "solid, 6 faces, 10 × 20 × 30" */
function describe(shape: ShapeSummary): string {
  const size = shape.bounding_box.size.map(fmt).join(" × ");
  return `${shape.type}, ${shape.faces} face${shape.faces === 1 ? "" : "s"}, ${size}`;
}

const COLORS: Record<Problem["severity"], string> = {
  error: "text-red-600 dark:text-red-400",
  warning: "text-amber-600 dark:text-amber-400",
  info: "text-zinc-600 dark:text-zinc-400",
};

export function ProblemsPanel({ problems, shape, computeMs, running }: Props) {
  const errors = problems.filter((p) => p.severity === "error").length;
  return (
    <div className="flex h-40 min-h-0 flex-col border-t border-zinc-200 bg-white dark:border-zinc-800 dark:bg-zinc-900">
      <div className="flex items-center gap-3 border-b border-zinc-200 px-3 py-1 text-xs dark:border-zinc-800">
        <span className="font-semibold">Output</span>
        <span className={errors ? COLORS.error : "text-zinc-500"}>
          {running ? "Checking…" : errors ? `${errors} error${errors > 1 ? "s" : ""}` : "OK"}
        </span>
        <span className="ml-auto text-zinc-500 tabular-nums">
          {shape !== null && describe(shape)}
          {computeMs !== null && ` · meshed in ${computeMs.toFixed(0)} ms`}
        </span>
      </div>
      <ul className="min-h-0 flex-1 overflow-y-auto px-3 py-1.5 font-mono text-xs">
        {problems.length === 0 && <li className="text-zinc-500">No errors, warnings or output.</li>}
        {problems.map((p, i) => (
          <li key={i} className={`whitespace-pre-wrap ${COLORS[p.severity]}`}>
            {p.message}
          </li>
        ))}
      </ul>
    </div>
  );
}
