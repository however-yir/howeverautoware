> Change Source: Autoware 30-point implementation request | Date: 2026-04-07

# Change Management

## File Attribution Rule

- Every changed file should include change source and date annotation.
- Annotation format:
  - Markdown: `> Change Source: ... | Date: YYYY-MM-DD`
  - Script/YAML/C++: comment line with same fields

## LTS Tag Rule

- Create LTS tag per stabilized branch snapshot:
- Format: `lts-autoware-YYYYMMDD`

## Upstream Merge Rule

- After each upstream merge, run:
  - `./scripts/post_upstream_merge.sh`
- Keep regression artifacts and KPI evidence in `reports/`.
