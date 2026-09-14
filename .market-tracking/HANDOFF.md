# Handoff to a local Claude Code session

Point your local session at this file:
"read .market-tracking/HANDOFF.md and pick up the market tracking"

## Get the files

    git fetch origin claude/computer-connection-status-0utklq
    git checkout claude/computer-connection-status-0utklq

That gives you everything that is portable:

    PROTOCOL.md          the run-book: which rankings to pull, tiering rule, schedule
    QUALITY-SCREEN.md    why the report leads with fundamentals, w/ the FNGR/MU example
    record.sh            appends one normalized observation row
    snapshots/           observations.csv - the durable data record

## What does NOT come with it

**1. The hourly schedule.** The cron job (`trig_013tHsoNaTpeei6aK3HYRfki`) is bound
to a specific cloud session (`session_01CkA2E9shEN5dzaknuBbNi8`). It fires *into
that session*. A local Claude Code session cannot receive those fires — there is
no equivalent local mechanism, and copying the repo does not copy the schedule.

**2. The Webull connection.** The cloud session has Webull as an MCP connector.
Your local install needs its own, configured via `claude mcp add` or /mcp. The
data in observations.csv is already collected and readable without it; pulling
NEW data locally requires it.

## Recommended split

Leave collection in the cloud, read the data locally.

The cloud session is already validated end to end and runs whether or not your
laptop is awake — which matters, because the sampling window is 9am-5pm ET on
weekdays. Locally you would need your machine powered on and unlocked across
that whole window, plus cron/launchd, plus the Webull MCP set up.

So: let the cloud job keep appending and pushing, and locally just

    git pull origin claude/computer-connection-status-0utklq

whenever you want the current data. Analysis, charting, and the actual report
all work fine locally against observations.csv with no connector at all.

## If you do want collection running locally instead

1. Configure the Webull MCP server in your local Claude Code.
2. Schedule it yourself — cron or launchd, hourly 9am-5pm ET weekdays — invoking
   Claude Code headless (`claude -p "follow .market-tracking/PROTOCOL.md"`).
3. Tell the cloud side to stand down, so you are not double-writing the same
   rows from two machines into one CSV.

Note the prefix warning in PROTOCOL.md applies locally too: resolve the Webull
tool names at runtime, do not hardcode `mcp__Webull__*`.
