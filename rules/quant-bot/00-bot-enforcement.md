# Investment Agent Enforcement Map

How each of the Ten Commandments becomes deterministic code in an AI-driven investment agent.

LLMs reason. Code enforces. Anywhere an LLM is in the decision path, a deterministic gate sits *after* the LLM and *before* the broker (or the human investor). The LLM proposes; the gate disposes.

This map is the same architecture used in trading systems, but the gates here are tuned for long-term investing rather than per-trade execution. The orientation is "capital preservation, value gap, business quality, management discipline, and edge honesty" rather than "stop-loss distance and turnover."

## Architecture

```
   ┌──────────────┐    proposal     ┌──────────────┐   approved action  ┌──────────┐
   │ LLM / signal │ ───────────────▶│ rule gates   │ ──────────────────▶│ broker / │
   │  generator   │                 │ (this layer) │                    │ investor │
   └──────────────┘                 └──────┬───────┘                    └────┬─────┘
                                           │ rejects + reasons               │ fills
                                           ▼                                 ▼
                                     immutable log ◀──── reconciliation ────┘
```

Three properties matter:
1. The LLM cannot bypass the gates. The gates are not advisory.
2. Every rejection is logged with a reason code.
3. Every fill is reconciled back against the proposal that triggered it.

## Commandment → gate

| # | Commandment | Deterministic gate | Reject reason codes |
|---|-------------|--------------------|---------------------|
| 1 | Capital preservation | `can_open()` | `no_permanent_loss_scenario`, `sized_to_force_selling_into_volatility`, `min_equity_floor_breached`, `single_factor_overexposure`, `leverage_not_reversible_without_forced_sale` |
| 2 | Buy value, not price | `passes_value_thesis()` | `no_independent_value_thesis`, `price_disguised_as_value`, `thesis_too_short_term_for_compounding` |
| 3 | Margin of safety | `passes_margin_of_safety()` | `entry_above_fair_value_minus_margin`, `margin_too_thin_for_noise` |
| 4 | Stock is a business | `passes_ownership_test()` | `no_business_understanding`, `holding_period_too_short_for_ownership_mindset`, `sell_logic_is_price_only_not_business` |
| 5 | Circle of competence | `in_circle()` | `not_in_universe`, `review_stale`, `no_business_model_summary` |
| 6 | Quality at fair price | `passes_quality_test()` | `no_durable_advantage`, `roic_below_compounding_threshold`, `growth_not_decomposed`, `cheap_without_a_thesis_for_change` |
| 7 | Management & capital allocation | `passes_management_test()` | `no_skin_in_the_game`, `persistent_dilution_without_value`, `value_destroying_acquisitions`, `buybacks_above_intrinsic_value`, `opaque_capital_allocation_communication` |
| 8 | Long-term compounding | `can_sell()`, `turnover_guard()`, `has_action_trigger()` | `invalid_sell_reason`, `turnover_budget_exceeded`, `no_signal_no_action` |
| 9 | Cycles & crowd psychology | `passes_second_level_test()`, `regime_adjusted_size()` | `no_consensus_view`, `no_differentiated_view`, `macro_forecast_as_stock_thesis`, `regime_haircut` |
| 10 | Default to diversification if no edge | `has_genuine_edge()`, `default_strategy_for()` | `no_documented_edge`, `entertainment_is_not_edge`, `index_default_recommended` |

Each gate maps to one file under `agent/risk/gates/` (suggested layout, not prescribed). Each rejection writes a row with `(timestamp, gate, reason_code, payload_hash)` so behavior is auditable after the fact.

**Rule 1 sits in front of every other gate.** A proposal that fails capital preservation is rejected before any of the value-grade tests run. The ordering reflects the principle: the goal of not permanently impairing capital outranks any individual analytical signal.

## The non-negotiables

These are not opinions. An agent that violates any of them is unsafe and must not run with real capital:

1. **No silent overrides.** Every gate can be overridden by a human, but every override is signed, dated, logged, and visible in the next-day report.
2. **No rule edits in-session.** Configuration changes during an active session are rejected by `rule_change_guard()`.
3. **No "auto-tuning" against live P&L.** The agent does not change thresholds because the recent return was disappointing. Parameter changes go through the same out-of-sample validation as the strategy itself.
4. **Immutable, append-only log.** Proposals, rejections, fills, P&L attributions — all written once, never edited.
5. **A kill switch the operator can hit in under one second.** It cancels resting orders, blocks new entries, and leaves existing positions for human decision. The kill switch is itself part of Rule 1 — it preserves capital when the agent or the world is doing something unexpected.
6. **Edge honesty is a first-class gate.** Before any active strategy is allowed to deploy capital, `has_genuine_edge()` must return `True` with documented evidence. Otherwise the agent recommends the low-cost diversified default.

## What the LLM is allowed to do

- Generate hypotheses (theses, valuations, quality assessments, sizing suggestions).
- Explain decisions in natural language for the human.
- Read logs and write post-mortems.
- Edit configuration *outside* a live session, under version control.
- Recommend "do nothing" or "buy the index" as legitimate outputs.

## What the LLM is not allowed to do

- Bypass a gate by retrying with a different prompt until the order goes through.
- Edit rule thresholds during a live session.
- Send orders that have not passed the gates.
- Mark its own homework — out-of-sample validation runs in a separate process with separate code paths.
- Treat narrative agreement with the consensus as analysis.

The Ten Commandments tell the agent what discipline looks like. This file is how that discipline is non-optional.
