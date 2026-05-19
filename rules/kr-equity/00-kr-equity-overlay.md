# Korean Equity Overlay (KOSPI / KOSDAQ)

The Ten Commandments are market-agnostic. This overlay adds the rules and frictions specific to the Korean cash-equity market that an AI agent must encode before it sends a single order.

Treat numbers below as a starting point — verify against the current rulebook (KRX / FSC) and your broker's API docs before going live.

## Transaction costs (2026 baseline)

Costs are subtracted *before* the margin-of-safety check, never after.

| Item | Rate | Notes |
|------|------|-------|
| KOSPI securities transaction tax | 0.05% (sell side) | Reduced from 0.15% effective 2026-01-01. |
| KOSDAQ securities transaction tax | 0.20% (sell side) | Increased from 0.15% effective 2026-01-01. |
| K-OTC | 0.20% (sell side) | Same as KOSDAQ effective 2026-01-01. |
| Broker commission | Broker-specific | Commonly 0.015%–0.25%. Read your contract. |
| Slippage | Strategy-specific | Model it; do not assume zero. |

Re-verify the table at every quarter-end and on every regulatory news event. The 2026 changes are recent — the agent should treat tax rates as configuration, not constants.

## Settlement and cash

- **Settlement cycle**: T+2. A sell on day T frees withdrawable cash on T+2.
- **Buying power vs withdrawable cash**: these are *different* numbers; the bot must reconcile both.
- **Day-trading constraints**: same-day round trips on the same name are allowed but reduce next-day buying power until settlement.

## Trading hours and auctions

- **Regular session**: 09:00–15:30 KST.
- **Opening single-price auction**: 08:30–09:00 (orders matched at the open).
- **Closing single-price auction**: 15:20–15:30 (orders matched at the close).
- **After-hours single-price auction**: 16:00–18:00, in 10-minute intervals.
- **Holidays**: KRX calendar. The bot must load it explicitly — do not assume "weekdays only".

The opening and closing auctions have different liquidity and price-discovery dynamics than continuous trading. Strategies tuned on continuous-session data must be revalidated for auction periods or excluded from them.

## Price limits and halts

- **Daily price limit**: ±30% from the previous day's close for most listed names. Tightens to a circuit-breaker if hit market-wide.
- **VI (Volatility Interruption)**: dynamic and static VIs trigger 2-minute single-price auctions. The bot must detect VI state and stop submitting marketable orders during it.
- **Investment caution / alert / designation**: KRX tags. Tagged names are eligible for trading but typically excluded by the whitelist (see [Circle of Competence](../common/03-circle-of-competence.md)).

## Order types worth knowing

- **Limit (지정가)**: default; required for any strategy that cares about price.
- **Market (시장가)**: use only for forced exits where time-priority beats price-priority.
- **Conditional limit / best-price / immediate-or-cancel / fill-or-kill**: supported by most brokers' APIs but with subtle behavior differences — read the broker's spec, do not assume.

## Regulatory and account-level rules

- **Algorithmic / automated trading under one's own name**: legal for retail when executed through a licensed broker's API; the operator remains responsible for all orders.
- **Short-selling**: restricted for retail and frequently subject to temporary bans. The bot must treat short availability as a runtime check, not a configuration assumption.
- **Foreign-investor flags, sector caps**: relevant for some names; if the universe touches them, encode the constraint.
- **Tax reporting**: capital-gains rules and reporting obligations change. The bot does not give tax advice; it logs trades cleanly so a human can.

## Checklist before any KR strategy goes live

- [ ] Tax table loaded from config and dated.
- [ ] T+2 buying-power model verified against the broker's API balance call.
- [ ] Session calendar (regular / auctions / holidays) loaded; no orders outside declared windows.
- [ ] VI / halt detection wired; the bot stands down during VI.
- [ ] Universe excludes 투자주의 / 투자경고 / 투자위험 / 관리종목 unless explicitly added by the operator.
- [ ] Short selling, if used, checks borrow availability at order time.
- [ ] All of the above is covered by integration tests against a paper account before any won of real capital touches the API.
