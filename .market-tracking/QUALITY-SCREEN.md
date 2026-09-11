# Quality screen — added 2026-08-29

The user's goal is choosing businesses to invest real money in, not watching
tickers move. Price ranking alone cannot serve that goal, so every core-tier
name also gets fundamentals pulled ONCE PER DAY (not hourly — these only
change quarterly).

    get_financial_indicators  type=ANNUAL count=3
    get_analyst_rating

Recorded to `snapshots/fundamentals.csv`:
  symbol, fiscal_year, net_margin, roe, roa, debt_to_assets, ocf_ps, eps

## Why this exists — the worked example

On 2026-08-28 the #1 gainer in the whole US market was FNGR (+130%).
Its actual financials:

  net margin   -29.0%   (was -10.5% in 2024 — deteriorating)
  ROE          -48.6%   (deteriorating)
  debt/assets   75.1%   (was 35.9% in 2024 — doubled)
  op cash flow  -$0.06/sh (burning cash)

Compare MU, up 13% over the month:

  net margin   +22.8%   (was -37.5% in 2023 — real turnaround)
  ROE          +17.2%
  debt/assets   34.6%   (stable)
  op cash flow  +$15.62/sh

Same feed. Opposite businesses. The biggest price gain in the market belonged
to the worse company. That is the entire argument for this file: report on
business quality first, price movement second.

## Reporting rule

The report leads with fundamentals and treats price action as context.
Never present a gainers list as a buy list.
