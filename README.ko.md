# AI 투자 에이전트를 위한 10계명

[English](README.md) | **한국어**

랜딩 페이지: **https://cskwork.github.io/investment-agent-rules/**

자금을 다루는 AI 에이전트(리서치, 사이징, 주문 집행 어디에 있든)를 위한 최소 드롭인 규칙 모음. 출처는 그 비용을 직접 치른 사람들이다:

**Graham, Buffett, Munger, Fisher, Lynch, Marks, Bogle, Malkiel.**

10개 규칙. 한국 시장 오버레이 1개. 투자 에이전트 enforcement 맵 1개. 군더더기 없음.

## 한 문장 결론

> 훌륭한 투자는 “자본을 먼저 지키고, 이해 가능한 우량 자산을 내재가치보다 싸게, 안전마진을 두고, 감정과 비용을 통제하며, 장기 보유하는 것”이다. 다만 스스로 우위가 없다고 판단되면, 저비용·분산·장기 보유가 최선의 기본값이다.

## 왜 필요한가

LLM 기반 투자 에이전트는 예측 가능한 방식으로 망가진다:

- 자본을 영구히 잃지 않는 것을 증명하기도 전에 수익률부터 최적화한다.
- 오르는 가격을 오르는 가치로 착각한다.
- 동종업종 멀티플과 최근 내러티브를 쌓아 “thesis”라고 부른다.
- 익숙한 종목을 능력범위 안이라고 착각한다.
- 스프레드시트는 좋은데 “경영진이 실제로 주주에게 현금을 돌려주는가”는 검증하지 않는다.
- 리스크를 변동성으로 정의해 놓고, 결국 바닥에서 강제 매도하는 사이즈로 진입한다.
- 합의(consensus)가 최근이라는 이유로 더 자신 있게 따라간다.
- 한 사이클도 검증되지 않은 우위를 우위라고 주장한다.
- “당신은 우위가 없습니다 — 인덱스를 사세요”라는 결론을 내리지 못한다.

10계명 — 그리고 *Korean Equity Overlay*, *Investment Agent Enforcement Map* — 이 모든 실패 모드를 막는 최소 룰 모음이다.

## 설치

### 한 줄 설치 (권장)

```bash
git clone https://github.com/cskwork/investment-agent-rules.git ~/investment-agent-rules
cd ~/investment-agent-rules && ./install.sh
```

파일은 `~/.claude/rules/investment/` 아래에 떨어진다. 프로젝트 `CLAUDE.md` / `AGENTS.md`에서 참조:

```markdown
@~/.claude/rules/investment/common/00-index.md
@~/.claude/rules/investment/kr-equity/00-kr-equity-overlay.md
@~/.claude/rules/investment/quant-bot/00-bot-enforcement.md
```

### 부분 설치

```bash
./install.sh common      # 10계명만
./install.sh kr-equity   # 한국 시장 오버레이만
./install.sh quant-bot   # 에이전트 enforcement 맵만
```

### 설치 경로 변경

```bash
INVESTMENT_RULES_DEST=~/my/path ./install.sh
```

## 10계명

1. **자본 보존이 먼저.** 영구 손실 금지. 50% 손실은 100% 수익이 있어야 회복된다. 자본 보존은 *목표(우산)*이고, 나머지 아홉 가지는 모두 그 목표를 지키는 *기법*이다. 중요한 손실은 *영구* 손실이지 변동성이 아니다 — 다만 강제 매도하는 사이즈로 들어가면 변동성이 영구손실로 변한다. — *Buffett (Rule No. 1), Marks*
2. **가격이 아니라 가치를 산다.** 출발점은 “이 자산이 무엇을 벌 수 있는가”다. 가격은 할인폭을 정할 뿐, 논거가 아니다. — *Graham, Marks*
3. **안전마진 없이 사지 않는다.** 내가 틀려도 살아남을 만큼 내재가치보다 충분히 낮게 사라. 입력값이 노이즈가 클수록 마진은 더 크게. — *Graham, Buffett*
4. **주식은 사업의 일부다.** 이 implied valuation에서 회사 전체를 살 의향이 있는가? 아니라면 주식 한 주도 사지 마라. — *Buffett (Owner's Manual)*
5. **능력의 범위 안에서만 투자한다.** 매출, 고객, 경쟁, 영구손실 시나리오를 한 문단으로 설명할 수 있는 것만 보유한다. 설명할 수 없으면 사지 마라 — 패스도 하나의 결정이지 실패가 아니다. — *Buffett, Lynch*
6. **평범한 기업을 헐값에 사기보다, 훌륭한 기업을 합리적 가격에.** 지속 가능한 해자, 사이클 전반의 높은 ROIC, 가격결정력, 긴 재투자 활주로. 싸다는 건 바닥이고, 품질이 곱셈이다. — *Fisher, Buffett, Munger*
7. **경영진과 자본배분을 검증한다.** 현금의 운명은 경영진이 결정한다. 내부자 지분, 자사주 매입 가격, 인수합병 성과, 희석, 부채 사용, 주주 커뮤니케이션을 본다. — *Buffett*
8. **장기 복리를 방해하지 마라.** 매도 사유 세 가지만 허용: 가설이 틀렸을 때, 사업 품질이 훼손됐을 때, 훨씬 더 좋은 기회가 생겼을 때. 시간은 시그널이 아니다. — *Munger, Buffett*
9. **사이클과 군중심리를 역이용하라.** 2차원적 사고: 합의는 이미 가격에 있다. 도취 국면에서는 사이즈 축소, 패닉 국면에서는 우량자산의 가격을 가장 면밀히 본다. — *Marks, Soros, Buffett*
10. **진짜 우위가 없다면, 저비용 분산을 기본값으로.** 우위(정보·분석·행동)는 주장이 아니라 검증되는 것. 없다면 광범위·저비용·장기 인덱스 보유가 정직한 답이다. — *Bogle, Malkiel*

각 규칙의 전체 본문, 체크리스트, “AI 투자 에이전트가 어떻게 강제하는가” 의사코드는 [`rules/common/`](rules/common/00-index.md)에 있다.

## 가장 중요한 5가지

10개 중에서도 핵심:

- **규칙 1** — 자본 보존 (모든 다른 룰을 묶는 우산).
- **규칙 2** — 가치, not 가격.
- **규칙 3** — 안전마진.
- **규칙 4** — 주식 = 사업.
- **규칙 10** — 우위 없으면 인덱스.

나머지 5개(능력범위, 품질, 경영진, 복리, 사이클)는 이 다섯 가지를 실행 가능하게 만드는 운영체제다.

## 매수 전 10문장 체크리스트

1. 이 포지션의 **영구손실 시나리오**를 글로 적었는가? 그 시나리오를 살아남을 수 있는가?
2. 이 사업이 돈을 버는 방식을 한 문단으로 설명할 수 있는가?
3. 현재 가격이 내재가치 추정치보다 의미 있게 낮은가?
4. 내 추정이 20~30% 틀려도 보호되는가?
5. 5년 이상 보유할 수 있는가?
6. 경쟁자가 쉽게 모방하기 어려운 지속 가능한 우위가 있는가?
7. 경영진은 장기 주주처럼 생각하고 자본을 쓰는가?
8. 매수 사유가 분석인가, 군중 추종을 분석으로 위장한 것인가?
9. 30~50% 드로다운을 견디고 보유할 수 있는 사이즈인가?
10. 정말 내가 우위가 있는가, 아니면 저비용 분산이 더 정직한 답인가?

## 저장소 구조

```
investment-agent-rules/
├── README.md
├── README.ko.md
├── LICENSE                       # MIT
├── install.sh                    # rules/ 를 ~/.claude/rules/investment/ 로 복사
└── rules/
    ├── common/                                       # 10계명
    │   ├── 00-index.md
    │   ├── 01-capital-preservation.md
    │   ├── 02-buy-value-not-price.md
    │   ├── 03-margin-of-safety.md
    │   ├── 04-stock-is-a-business.md
    │   ├── 05-circle-of-competence.md
    │   ├── 06-quality-at-fair-price.md
    │   ├── 07-management-and-capital-allocation.md
    │   ├── 08-long-term-compounding.md
    │   ├── 09-cycles-and-crowd-psychology.md
    │   └── 10-default-to-low-cost-diversification.md
    ├── kr-equity/                                    # 한국 시장 특화
    │   └── 00-kr-equity-overlay.md
    └── quant-bot/                                    # 계명 → 코드 게이트 매핑
        └── 00-bot-enforcement.md
```

## 설계 노트

- **명령형, 권고형 X.** 모든 계명은 지시문이자 게이트다 — 가치 진술이 아니다.
- **중요한 곳엔 의사코드.** 원칙은 끄덕이긴 쉽고 강제하긴 어렵다. 각 계명 끝에 그것을 강제하는 게이트.
- **자본 보존은 또 하나의 규칙이 아니라 우산이다.** Rule 1은 목표를 명명하고, 나머지 아홉 가지는 그 목표를 지키는 기법이다. 안전마진, 포지션 사이징, 분산, 사이클 인식은 모두 “영구손실은 에이전트가 회복할 수 없는 유일한 사건”이라는 사실 때문에 존재한다.
- **영구손실, not 변동성.** Marks의 정의는 Rule 1에 직접 내장되어 있다. 이익체력이 그대로인데 가격만 하락한 것은 리스크 이벤트가 아니다. 강제 매도하는 사이즈일 때만 변동성이 영구손실이 된다.
- **투자 우선, 트레이딩은 그다음.** 이전 버전은 트레이드 단위 규율(stop 거리, stop 기반 사이징, 킬 스위치)에 무게가 실려 있었다. 이번 버전은 “보유자급” 투자 — 가치, 사업 품질, 경영진, 복리 — 를 중심에 두고, 트레이딩 규율은 보조 레이어로 둔다.
- **우위 정직성은 1급 규칙이다.** 대부분의 투자자는 지속 가능한 우위가 없다. 규칙 10은 그 불편한 진실을 단순 면책 조항이 아니라 기본 동작으로 만든다.
- **시장 무관 코어 + 시장 특화 오버레이.** 10계명은 어디서나 통한다. KR 오버레이는 한국 현물주식의 차이(세금, 결제, 단일가, VI, KSD)를 인코딩한다.
- **LLM은 제안, 코드는 처분.** enforcement 맵은 “LLM이 루프에 있다 = 기본적으로 안전하지 않다”는 전제로 만들었다. 게이트가 안전장치다.

## 참고 문헌

이 룰셋은 다음 자료에서 반복적으로 등장하는 패턴을 정리한 것이다.

- Benjamin Graham, *The Intelligent Investor* — 안전마진, 투자자 vs 투기자, Mr. Market.
- Warren Buffett, 버크셔 *Owner's Manual*과 연례 주주서한 — Rule No. 1, 주식은 사업의 일부, 내재가치, 경영진의 자본배분.
- Charlie Munger, *Poor Charlie's Almanack* — 다학제 정신모형, 역발상(inversion), 복리를 끊지 마라.
- Philip Fisher, *Common Stocks and Uncommon Profits* — 품질, 경영진, 스커틀버트 리서치, 가격결정력.
- Peter Lynch, *One Up on Wall Street* — 이해 가능한 것에 투자하되, 관찰은 리서치의 끝이 아니라 시작.
- Howard Marks, *The Most Important Thing*과 Oaktree 메모 — 영구손실로서의 리스크(변동성 X), 2차원적 사고, 사이클.
- John C. Bogle, *The Little Book of Common Sense Investing* — 비용, 분산, 인덱스 겸손.
- Burton Malkiel, *A Random Walk Down Wall Street* — 효율적 시장과 “기본값(default)” 전략의 근거.

## 동반 프로젝트

이 룰셋은 AI 기반 한국 주식 투자 워크플로 [`kr-ai-trader`](https://github.com/cskwork/kr-ai-trader)의 규율을 정의한다. 룰이 먼저, 코드가 나중이다 — 의도된 순서.

## 관련 프로젝트

- [coding-agent-rules](https://github.com/cskwork/coding-agent-rules) — 코딩 에이전트를 위한 10계명
- [planning-doc-rules](https://github.com/cskwork/planning-doc-rules) — 기획서 작성 10원칙

## 커스터마이징

Fork. `rules/common/`은 마지막에 손대고, 오버레이와 enforcement 맵부터 손대라.

새 규칙은:
- 맨 위는 한 문장. 그 아래에 체크리스트와 코드 게이트.
- 누군가 실제로 비용을 치른 실패 모드에 대응해야 한다.
- 기존 규칙과 중복되지 않아야 한다.

15계명을 넘으면 그건 룰셋이 아니라 교과서다.

## 면책 (Disclaimer)

교육 목적의 참고 자료다. 투자 자문이 아니다. 시장은 이 문서가 예상하지 못한 방식으로도 손실을 만든다. 저자는 너의 fiduciary가 아니다.

## 라이선스

MIT. [LICENSE](LICENSE) 참조.
