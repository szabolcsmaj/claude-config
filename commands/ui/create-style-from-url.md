# UI Style Specification Generator

You are helping the user create a comprehensive UI style specification by analyzing URLs.

## Input

Reference URL: $ARGUMENTS

---

## UI Design Styles Reference Database

Use this reference to classify analyzed pages. Match against one or more styles, or identify if it's a new style not in this list.

### Structural/Layout Styles

| Style | Key Characteristics | Example Products |
|-------|---------------------|------------------|
| **Brutalist** | Raw, intentionally unpolished, exposed structure, system fonts, harsh/clashing colors, visible borders, no decoration | Craigslist, early HN, some art portfolios |
| **Bento Grid** | Asymmetric grid of varied-size boxes, feature showcases, mixed content types per cell | Apple product pages, many SaaS landing pages |
| **Editorial/Magazine** | Typography-dominant, dramatic whitespace, layered elements, pull quotes, large imagery | Medium, NYT, Stripe blog |
| **Dashboard Dense** | Information-dense, compact spacing, data-first, small fonts, many widgets | Linear, Datadog, Grafana, trading platforms |
| **Card-Based** | Everything in distinct card containers, uniform or masonry grid | Trello, Pinterest, Notion databases |
| **Single Column** | Focused vertical scroll, minimal navigation, content-centered | Notion docs, Medium articles, Substack |
| **Split Screen** | Two distinct panels, often 50/50 or 60/40, contrasting content | Many landing pages, comparison tools |
| **Infinite Canvas** | Zoomable, pannable workspace, no fixed boundaries | Figma, Miro, Excalidraw |

### Surface/Material Styles

| Style | Key Characteristics | Example Products |
|-------|---------------------|------------------|
| **Glassmorphism** | Frosted glass effect, backdrop-blur, transparency, layered panels, light borders | macOS Big Sur+, many modern dashboards |
| **Neumorphism/Soft UI** | Soft inset/outset shadows, extruded elements, monochromatic, subtle depth | Calculator apps, some banking UIs |
| **Claymorphism** | 3D clay-like appearance, inflated/puffy shapes, playful colored shadows, rounded | Illustrations, playful apps |
| **Flat Design** | Zero shadows, solid colors, no gradients, crisp edges, minimal depth | Windows 8 Metro, early iOS 7+ |
| **Material Design** | Elevation shadows, ripple effects, FABs, specific motion curves, paper metaphor | Google apps, Android native |
| **Skeuomorphism** | Realistic textures, mimics physical objects, leather/wood/metal textures | Old iOS (pre-7), vintage apps |
| **Gradient Mesh** | Complex multi-color gradients, blob shapes, vibrant color transitions | Stripe, modern SaaS marketing |

### Aesthetic/Mood Styles

| Style | Key Characteristics | Example Products |
|-------|---------------------|------------------|
| **Corporate Minimal** | Clean, safe, generous whitespace, muted colors, professional | Stripe dashboard, Notion, Linear |
| **Dark Mode Native** | Designed dark-first (not inverted light), careful contrast, glowing accents | Discord, Spotify, VS Code, Vercel |
| **Maximalist** | Busy, layered, decorative, many competing elements, bold patterns | Fashion sites, some gaming UIs |
| **Retro/Y2K** | 90s-2000s aesthetics, pixel elements, gradients, chunky borders, nostalgia | Poolsuite, some indie games |
| **Cyberpunk/Neon** | Dark backgrounds, neon accent colors (cyan, magenta, green), tech-noir, glitch effects | Gaming dashboards, hacker tools |
| **Organic/Natural** | Earth tones (greens, browns, creams), rounded shapes, nature imagery, calm | Wellness apps, eco brands |
| **Memphis Design** | Bold geometric shapes, clashing bright colors, playful, 80s revival | Figma marketing, creative tools |
| **Swiss/International** | Strict grid, Helvetica-style sans-serif, functional, minimal decoration | Many corporate sites, gov sites |
| **Bauhaus** | Primary colors (red/blue/yellow + black/white), geometric shapes, functional | Art institutions, design portfolios |
| **Art Deco** | Geometric patterns, gold/brass accents, symmetry, luxury feel, ornate | Luxury brands, hotels, finance |
| **Vaporwave** | Pastels (pink, cyan, purple), gradients, retro-futuristic, surreal, 80s references | Music apps, aesthetic projects |
| **Monochrome** | Single color family, relies on shades/tints, typography-focused | Many developer tools, minimal portfolios |

### Interaction-Defined Styles

| Style | Key Characteristics | Example Products |
|-------|---------------------|------------------|
| **Command-Palette First** | Keyboard-driven, cmd+k searchable, minimal mouse needed, power-user focused | Raycast, Linear, Superhuman, VS Code |
| **Gesture-Based** | Swipe actions, drag-to-reorder, touch-optimized, mobile-first patterns | Tinder, iOS Mail, many mobile apps |
| **Wizard/Step-Flow** | Progressive disclosure, numbered steps, guided flows, one thing at a time | Onboarding flows, Typeform |
| **Conversational** | Chat-like interface, message bubbles, AI assistant patterns | ChatGPT, Intercom, support widgets |

### Hybrid/Trending Styles (2023-2025)

| Style | Key Characteristics | Example Products |
|-------|---------------------|------------------|
| **Linear-Style** | Dark + purple/blue accents, command palette, dense but clean, keyboard-first | Linear, Raycast, Arc |
| **Notion-Style** | Block-based, slash commands, inline editing, flexible layouts, wiki-like | Notion, Coda, Craft |
| **Vercel-Style** | Minimal, lots of black/white, subtle gradients, developer-focused, clean | Vercel, Next.js docs |
| **Stripe-Style** | Gradients + clean UI, excellent docs, animated illustrations, polished | Stripe, modern fintech |

---

## Your Task

### Step 0: Classify the Initial URL

Before deep analysis, determine what type of page this is:

**Page Type Classification:**
| Type | Characteristics | What It Reveals |
|------|-----------------|-----------------|
| **Marketing/Landing** | Hero sections, CTAs, feature showcases, testimonials | Brand colors, marketing typography, illustration style |
| **Documentation** | Sidebar nav, code blocks, search, content-heavy | Reading typography, code styling, navigation patterns |
| **Blog/Content** | Article layout, author info, related posts | Editorial style, image treatment, content typography |
| **Product/App UI** | Dashboard, forms, tables, authenticated views | Actual component styles, data density, interaction patterns |
| **Pricing/Comparison** | Tables, feature lists, plan cards | Card styles, table design, CTA treatment |
| **Login/Auth** | Forms, social buttons, minimal layout | Form styling, button variants, error states |
| **Changelog/Updates** | Timeline, version numbers, categorized entries | List styles, badge/tag design, date formatting |

**IMPORTANT:** Marketing pages and product UIs often have DIFFERENT design systems. Ask the user which they want to emulate.

### Step 1: Smart Page Discovery

After analyzing the initial URL:

1. **Extract the base domain** from the provided URL
2. **Probe for common subpages** (use WebFetch, handle 404s gracefully):
   - `/docs` or `/documentation` - documentation style
   - `/pricing` - pricing cards, comparison tables
   - `/blog` - content/editorial style
   - `/features` - feature presentation style
   - `/about` - team/company page style
   - `/login` or `/signin` - form styling
   - `/changelog` or `/releases` - list/timeline style
   - `/contact` - form styling

3. **Report what you found:**
```markdown
## Discovered Pages

| Page | URL | Status | Page Type |
|------|-----|--------|-----------|
| Main | [url] | ✓ Analyzed | Marketing |
| Docs | [url]/docs | ✓ Found | Documentation |
| Pricing | [url]/pricing | ✓ Found | Pricing |
| Blog | [url]/blog | ✗ Not found | - |
| Login | [url]/login | ✓ Found | Auth |
```

4. **Ask the user:**
   - "I found these accessible pages. Which should I analyze for style extraction? (I recommend analyzing 3-5 diverse page types for a complete picture)"
   - "Is there a specific page type you care most about? (e.g., 'I want my app to look like their dashboard, not their marketing site')"
   - "Do you have URLs to additional pages I should analyze? (e.g., a public demo, a specific feature page)"

**Limit: Analyze maximum 8 pages total to keep focused.**

### Step 2: Multi-Page Analysis

For each selected page, use WebFetch to extract:

**Automatically Detectable:**
- [ ] Color palette (primary, secondary, accent, background, text colors - exact hex values)
- [ ] Typography (font families, sizes, weights, line heights)
- [ ] CSS framework detected (Tailwind classes, Bootstrap, custom)
- [ ] Component library hints (shadcn, Radix, Headless UI, Vuetify, Nuxt UI, PrimeVue)
- [ ] Border radius values
- [ ] Shadow styles
- [ ] Spacing patterns
- [ ] Layout system (grid type, container widths)

**Page-Type Specific Extraction:**
- **Docs pages:** Sidebar width, code block styling, heading hierarchy, search UI
- **Pricing pages:** Card layout, feature list styling, CTA button variants
- **Blog pages:** Article width, image sizing, author components, related posts
- **Login pages:** Form field styling, button styling, social auth buttons, error states
- **Dashboard pages:** Widget/card density, table styling, navigation patterns

### Step 3: Cross-Page Consistency Analysis

After analyzing multiple pages, identify:

```markdown
## Design System Consistency Report

### Consistent Across All Pages:
- Colors: [which colors are universal]
- Typography: [which fonts appear everywhere]
- Components: [which components look the same]

### Variations by Page Type:
| Element | Marketing | Docs | App/Dashboard |
|---------|-----------|------|---------------|
| Primary font | [x] | [y] | [z] |
| Spacing density | Spacious | Moderate | Compact |
| Border radius | 16px | 8px | 4px |

### Notable Inconsistencies:
- [List any style conflicts between pages]

### Recommendation:
"The [page type] pages best represent the style you likely want for your app because [reason]."
```

### Step 4: Match Against Style Reference Database

**CRITICAL STEP:** Compare findings against the UI Design Styles Reference Database above.

Determine:
1. **Primary Style Match:** Which style from the database best describes this site? (Pick 1)
2. **Secondary Style Influences:** What other styles are present? (Pick 0-3)
3. **Confidence Level:** How well does it match? (Strong match / Partial match / Weak match)
4. **Style Varies by Page Type?** Note if marketing vs. product have different styles.

**If NO style matches well:**
- Describe the unique characteristics that don't fit existing categories
- Propose a NEW style name and definition
- Ask: "This appears to be a style not in my reference database. I'd call it **[Proposed Name]** characterized by [characteristics]. Should I add this to the style reference for future use?"

Present the style matching:

```markdown
## Style Classification

### Primary Style: [Style Name]
**Confidence:** [Strong/Partial/Weak]
**Best represented on:** [which page type]
**Matching characteristics:**
- [bullet points of what matches]

### Secondary Influences:
- **[Style Name]:** [which elements match, on which pages]
- **[Style Name]:** [which elements match, on which pages]

### Style by Page Type:
| Page Type | Primary Style | Notes |
|-----------|---------------|-------|
| Marketing | [style] | [notes] |
| Docs | [style] | [notes] |
| App | [style] | [notes] |

### Deviations from Standard:
- [What differs from the matched style's typical implementation]
```

### Step 5: Present Consolidated Findings

Merge findings from all analyzed pages:

```markdown
## Extracted Style Specification

### Pages Analyzed
1. [URL] - [Page Type] - [Primary style found]
2. [URL] - [Page Type] - [Primary style found]
...

### Style Classification
[From Step 4]

### Colors (Consolidated)
| Role | Hex | Found On | Usage |
|------|-----|----------|-------|
| Primary | #xxx | All pages | Buttons, links |
| Secondary | #xxx | Marketing only | CTAs |
| ... | | | |

### Typography
- Headings: [Font Family], weights used: [...]
- Body: [Font Family], base size: [...]
- Mono/Code: [Font Family] (found on: docs, blog)

### Framework/Libraries Detected
- CSS: [Tailwind / Bootstrap / UnoCSS / Custom]
- Components: [Detected library or "Unknown"]
- Icons: [Detected or "Unknown"]

### Measurements
- Border radius: [values by page type]
- Base spacing unit: [estimated]
- Container max-width: [value]
- Shadows: [description]

### Layout Patterns by Page Type
- Marketing: [description]
- Docs: [description]
- App: [description]
```

### Step 6: Interactive Clarification

After presenting findings, ASK the user:

1. **Page Type Preference:**
   - "Your marketing site and product pages have different styles. Which do you want to base your spec on?"
   - "Should I create separate specs for marketing vs. app pages?"

2. **Style Confirmation:**
   - "I classified this as **[Style]** with **[Secondary]** influences. Does that match your intent?"
   - If new style proposed: "Should I add **[Proposed Style]** to the reference database?"

3. **Missing Information:**
   - "I couldn't detect the icon library. Do you want: Lucide, Heroicons, Phosphor, Tabler, or custom SVGs?"
   - "The component library isn't clear. For Nuxt, would you prefer: Nuxt UI, shadcn-vue, Radix Vue, PrimeVue, or Headless UI?"

4. **Contradictions or Choices:**
   - "The site uses both sharp (docs) and rounded (marketing) corners. Which do you prefer?"
   - "I see both card-based and list layouts. What's your primary content display preference?"

5. **Deeper Style Questions:**
   - "How should loading states appear? (Skeletons / Spinners / Shimmer / None)"
   - "What's your button interaction style? (Scale / Color shift / Shadow lift / Ripple)"
   - "Empty states: Illustrated / Minimal text / Call-to-action focused?"
   - "Form style: Floating labels / Stacked / Inline / Bordered inputs?"
   - "Navigation pattern: Sidebar / Top bar / Command palette / Breadcrumbs?"

6. **Additional URLs:**
   - "Do you have additional URLs to reference for specific components? (e.g., a page with good table design, a settings page)"
   - "Any other products whose [tables/forms/dashboards/etc.] you'd like to emulate?"

7. **Anti-Patterns:**
   - "What should this NOT look like? Any styles from the reference to explicitly avoid?"

### Step 7: Generate Final Specification

After gathering all input, produce a complete specification file:

```markdown
# UI Style Specification: [Project Name]

## Design Direction
- **Primary Style:** [Style from database]
- **Secondary Influences:** [Other styles]
- **Inspiration:** [URLs analyzed]
- **Mood:** [2-3 descriptive words]

## Style Reference
> [Brief description of the primary style from the database, so future readers understand the intent]

## Source Analysis
| URL | Page Type | Key Extractions |
|-----|-----------|-----------------|
| [url] | [type] | [what was extracted] |
| ... | | |

## Color System
| Token | Light Mode | Dark Mode | Usage |
|-------|------------|-----------|-------|
| --color-primary | #xxx | #xxx | Buttons, links, accents |
| --color-secondary | #xxx | #xxx | Secondary actions |
| --color-accent | #xxx | #xxx | Highlights, badges |
| --color-background | #xxx | #xxx | Page background |
| --color-surface | #xxx | #xxx | Cards, elevated elements |
| --color-text | #xxx | #xxx | Body text |
| --color-text-muted | #xxx | #xxx | Secondary text |
| --color-border | #xxx | #xxx | Dividers, input borders |
| --color-error | #xxx | #xxx | Error states |
| --color-warning | #xxx | #xxx | Warning states |
| --color-success | #xxx | #xxx | Success states |
| --color-info | #xxx | #xxx | Info states |

## Typography
```css
--font-heading: '[Font]', [fallback];
--font-body: '[Font]', [fallback];
--font-mono: '[Font]', monospace;

--text-xs: 0.75rem;    /* 12px */
--text-sm: 0.875rem;   /* 14px */
--text-base: 1rem;     /* 16px */
--text-lg: 1.125rem;   /* 18px */
--text-xl: 1.25rem;    /* 20px */
--text-2xl: 1.5rem;    /* 24px */
--text-3xl: 1.875rem;  /* 30px */
--text-4xl: 2.25rem;   /* 36px */

--font-weight-normal: 400;
--font-weight-medium: 500;
--font-weight-semibold: 600;
--font-weight-bold: 700;

--line-height-tight: 1.25;
--line-height-normal: 1.5;
--line-height-relaxed: 1.75;
```

## Spacing & Layout
```css
--radius-none: 0;
--radius-sm: [x]px;
--radius-md: [x]px;
--radius-lg: [x]px;
--radius-xl: [x]px;
--radius-full: 9999px;

--spacing-1: 0.25rem;  /* 4px */
--spacing-2: 0.5rem;   /* 8px */
--spacing-3: 0.75rem;  /* 12px */
--spacing-4: 1rem;     /* 16px */
--spacing-6: 1.5rem;   /* 24px */
--spacing-8: 2rem;     /* 32px */
--spacing-12: 3rem;    /* 48px */
--spacing-16: 4rem;    /* 64px */

--container-sm: 640px;
--container-md: 768px;
--container-lg: 1024px;
--container-xl: 1280px;
```

## Shadows
```css
--shadow-sm: [value];
--shadow-md: [value];
--shadow-lg: [value];
--shadow-xl: [value];
--shadow-inner: [value];
```

## Component Library
- **Framework:** Nuxt 3
- **CSS:** [Tailwind / UnoCSS / custom]
- **Components:** [Library choice]
- **Icons:** [Icon library]
- **Fonts Source:** [Google Fonts / Adobe / Self-hosted]

## Component Specifications

### Buttons
- Border radius: [value]
- Padding: [value]
- Font weight: [value]
- Text transform: [none/uppercase]
- Variants: [primary, secondary, ghost, destructive]
- Hover: [behavior]
- Active/Press: [behavior]
- Disabled: [appearance]
- Focus: [ring style]

### Cards
- Background: [solid/gradient/blur]
- Border: [none/subtle/prominent]
- Border radius: [value]
- Shadow: [style]
- Hover: [behavior]
- Padding: [value]

### Forms
- Input style: [bordered/underline/filled]
- Label position: [above/floating/inline]
- Border radius: [value]
- Error display: [below/tooltip/border-color]
- Focus state: [ring/border/glow]
- Placeholder style: [color, italic?]

### Tables
- Header style: [sticky/scrollable, background]
- Row hover: [highlight color/none]
- Row striping: [yes/no]
- Borders: [full/horizontal/none]
- Density: [compact/comfortable]
- Cell padding: [value]

### Navigation
- Primary: [sidebar/topbar/command-palette]
- Sidebar width: [collapsed/expanded values]
- Mobile: [drawer/bottom-bar/hamburger]
- Active indicator: [background/border/icon]
- Hover state: [description]

### Modals/Dialogs
- Overlay: [color, opacity]
- Border radius: [value]
- Animation: [fade/scale/slide]
- Close button: [position, style]

### Feedback & States
- Loading: [skeleton/spinner/shimmer]
- Empty: [illustration/text/CTA]
- Error: [toast/inline/modal]
- Success: [toast/inline/redirect]
- Toast position: [top-right/bottom-right/top-center/bottom-center]

## Micro-Interactions
- Page transitions: [slide/fade/none]
- Element enter: [fade-up/scale/none]
- Button press: [scale-down/darken/none]
- Hover timing: [instant/150ms/300ms]
- Default easing: [ease-out/ease-in-out/spring]

## Anti-Patterns (DO NOT USE)
Based on **[Primary Style]**, avoid:
- [Style-specific anti-patterns]
- [User-specified anti-patterns]

## Reference URLs
| URL | What to reference |
|-----|-------------------|
| [url] | [specific elements] |
| ... | |

## Notes
[Any additional context or decisions made during specification]
```

### Step 8: Handle New Style Additions

If the user confirms a new style should be added, tell them:

"To add **[New Style Name]** to the reference database, add this entry to `~/.claude/commands/ui/create-style-from-url.md` in the appropriate category table:

```markdown
| **[New Style Name]** | [Key characteristics] | [Example products] |
```

I recommend adding it to the **[suggested category]** section."

### Step 9: Offer Next Steps

Ask the user:
- "Should I save this specification to a file in your project? (e.g., `docs/ui-style-spec.md` or `UI_STYLE.md`)"
- "Want me to generate a Tailwind config (`tailwind.config.ts`) based on these values?"
- "Should I create a CSS variables file for these tokens?"
- "Should I create example components demonstrating this style?"
