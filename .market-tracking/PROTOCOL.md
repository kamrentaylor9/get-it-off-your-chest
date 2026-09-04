# Market tracking run-book

Standing task from the user (2026-08-29): "track all the different businesses
that are doing well right now ... for the next day or so or until I come and
ask for the report."

## On every scheduled wake, do exactly this

1. Call these Webull MCP tools (US_STOCK):
   - `get_gainers_losers` rank_type=DAY_1   sort_by=MARKET_VALUE dir=DESC size=30
   - `get_gainers_losers` rank_type=WEEK_52 sort_by=MARKET_VALUE dir=DESC size=30
   - `get_gainers_losers` rank_type=MONTH_1 sort_by=MARKET_VALUE dir=DESC size=30
   - `get_most_active`    rank_type=VOLUME  sort_by=VOLUME       dir=DESC size=20
   - `get_52_week_high_low` rank_type=NEW_HIGH sort_by=MARKET_VALUE dir=DESC size=20
   - `get_market_sectors` agg_type=MARKET_VALUE period=D1 dir=DESC size=15
2. Append rows to `snapshots/observations.csv` via `./record.sh` (see below).
3. Commit and push to `claude/computer-connection-status-0utklq`.
4. Do NOT message the user. Silent unless something breaks or a name moves
   >8% intraday. The user asks for the report when they want it.

## Inclusion rule ("businesses doing well")

Raw daily-gainer lists are ~90% sub-$1 microcap shells (FNGR, CHAI, CYAB...).
Those are not businesses doing well; they are penny-stock churn. Track them
only in the `junk` tier, never in the headline report.

- tier `core`  : market_value >= $2B AND price >= $5   <- the real report
- tier `mid`   : market_value >= $300M AND price >= $2
- tier `junk`  : everything else (recorded, reported only as a footnote)

## record.sh usage

    ./record.sh <tier> <source> <symbol> <name> <price> <change_ratio> <volume> <market_value>

Timestamp is added automatically in UTC.

## Schedule

Cron fires hourly 13:00-21:00 UTC on weekdays (covers 9am-5pm ET, i.e.
pre-market through the close). US markets are CLOSED Sat 8/29 and Sun 8/30.
First live session is Monday 2026-08-31.

## Tool names are NOT stable across wakes

Validated 2026-08-29: after a scheduled wake the Webull MCP server came back
under a different prefix — `mcp__Webull__*` became
`mcp__dfdeb13a-6d4f-4bf0-8871-427a9e613656__*`, and the old names were gone.
The connector itself survives the resume; only the prefix changes.

So on every wake, do NOT assume a prefix. Resolve the tools first:

    ToolSearch  query="get_gainers_losers get_most_active"

then call whatever prefix comes back. All tool names in this run-book are
deliberately written bare for that reason.

## Holiday note

Monday 2026-09-07 is Labor Day; US markets are closed. The cron fires on
weekdays regardless, so that day's snapshots will return stale Friday data.
Record them as tier `holiday` or skip, but do not present them as live.
