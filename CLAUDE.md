# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Dagster data orchestration project using the `dg` CLI tool. The project follows Dagster's modern project structure with definitions loaded from a `defs` folder.

## Common Commands

All commands should be run from the `dagster-evidence-example/` subdirectory:

```bash
cd dagster-evidence-example

# Install dependencies (using uv)
uv sync

# Activate virtual environment
source .venv/bin/activate

# Start Dagster development server (UI at http://localhost:3000)
dg dev

# Alternative: install with pip
pip install -e ".[dev]"
```

## Architecture

- **Entry point**: `src/dagster_evidence_example/definitions.py` - Uses `@definitions` decorator with `load_from_defs_folder` to auto-discover Dagster definitions
- **Definitions folder**: `src/dagster_evidence_example/defs/` - Place assets, jobs, schedules, sensors, and resources here
- **Components**: Custom components can be added to `dagster_evidence_example.components` module (configured in `pyproject.toml` under `tool.dg.project.registry_modules`)
- **Tests**: `tests/` directory

## Configuration

The `pyproject.toml` contains Dagster-specific configuration under `[tool.dg]`:
- `directory_type = "project"` - This is a standalone Dagster project
- `root_module = "dagster_evidence_example"` - The Python module name
- `registry_modules` - Modules for component discovery
