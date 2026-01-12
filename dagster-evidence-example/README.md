# Dagster + Evidence Integration Example

This project demonstrates the integration between [Dagster](https://dagster.io/) and [Evidence.dev](https://evidence.dev/), enabling data orchestration with automated BI dashboard deployment.

**Live Demo:** [https://milicevica23.github.io/dagster-evidence-example/](https://milicevica23.github.io/dagster-evidence-example/)

## Overview

This integration provides:

- **Auto-generated Assets**: Automatically discovers SQL sources in your Evidence project and creates corresponding Dagster assets
- **Declarative Configuration**: Define your Evidence project and deployment target in a simple YAML file
- **GitHub Pages Deployment**: Built-in support for deploying Evidence dashboards to GitHub Pages
- **Extendable Architecture**: Easily add new deployment targets (Netlify, Vercel, custom) or data sources

## How It Works

### Auto-Generated Assets and Sources

The integration scans your Evidence project's `sources/` folder and automatically:

1. Discovers data source connections (DuckDB, Motherduck, BigQuery, etc.)
2. Creates a Dagster asset for each SQL query file
3. Generates a main `build_and_deploy_evidence_project` asset that depends on all source assets
4. Tracks lineage and dependencies across your data pipeline

When you materialize the build asset, it:
- Installs Evidence dependencies
- Runs source queries
- Builds the static site
- Deploys to your configured target

### Component Configuration

Define your Evidence project in `defs.yaml`:

```yaml
# src/dagster_evidence_example/defs/dagster_evidence_github_pages/defs.yaml

type: dagster_evidence.EvidenceProjectComponentV2
attributes:
  evidence_project:
    project_type: local
    project_path: ../../../evidence_project
    project_deployment:
      type: github_pages
      github_repo: milicevica23/dagster-evidence-example
```

This declarative approach means Dagster automatically loads and registers all definitions from your `defs/` folder.

## Project Structure

```
dagster-evidence-example/
├── src/
│   ├── dagster_evidence_example/
│   │   ├── definitions.py          # Entry point with load_from_defs_folder
│   │   └── defs/
│   │       └── dagster_evidence_github_pages/
│   │           └── defs.yaml       # Component configuration
│   └── evidence_project/           # Evidence.dev BI project
│       ├── pages/                  # Dashboard pages (markdown)
│       ├── sources/                # Data sources and SQL queries
│       └── evidence.config.yaml    # Evidence configuration
├── pyproject.toml
└── README.md
```

## Getting Started

### Prerequisites

- Python 3.9+
- Node.js (for Evidence)
- [uv](https://docs.astral.sh/uv/) (recommended) or pip

### Installation

**Option 1: uv (recommended)**

```bash
uv sync
source .venv/bin/activate
```

**Option 2: pip**

```bash
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install -e ".[dev]"
```

### Running Dagster

Start the Dagster development server:

```bash
dg dev
```

Open [http://localhost:3000](http://localhost:3000) to view the Dagster UI and materialize your Evidence assets.

## Extensibility

### Deployment Targets

The architecture supports multiple deployment targets through the `BaseEvidenceProjectDeployment` class:

| Target | Status | Description |
|--------|--------|-------------|
| GitHub Pages | Implemented | Deploy to `gh-pages` branch |
| Custom Command | Implemented | Run any deployment script |
| Netlify | Planned | Deploy to Netlify |
| Evidence Studio | Future | Native Evidence Cloud integration |

To add a new deployment target, extend `BaseEvidenceProjectDeployment` and implement the `deploy_evidence_project` method.

### Data Sources

Supported source types:
- DuckDB (local files)
- Motherduck (cloud DuckDB)
- BigQuery
- PostgreSQL
- Snowflake
- CSV files

Sources are automatically discovered from your Evidence project's `sources/` folder.

## Future Roadmap

- **Evidence Studio Integration**: Native support for deploying to Evidence's managed cloud platform
- **Incremental Builds**: Only rebuild when source data changes
- **Source Freshness Checks**: Monitor data source health

## Learn More

- [Dagster Documentation](https://docs.dagster.io/)
- [Evidence.dev Documentation](https://docs.evidence.dev/)
- [Dagster University](https://courses.dagster.io/)
- [Dagster Slack Community](https://dagster.io/slack)

---

## TODO

- [ ] **Implement different data sources with dependencies**: Add support for multiple source types (PostgreSQL, Snowflake, BigQuery) with proper dependency tracking between sources
- [ ] **Create sensors for source observation**: Build sensors that monitor data sources for changes and automatically trigger dashboard refreshes when upstream data is updated
- [ ] **Add source freshness monitoring**: Implement freshness policies to track when sources were last updated and alert on stale data
