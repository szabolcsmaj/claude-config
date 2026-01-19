# UI Style Specification Generator

You are helping the user create a comprehensive UI style specification from a reference URL or screenshot.

## Input

Reference URL: $ARGUMENTS

---

## UI Design Styles Reference Database

Use this reference to classify the analyzed URL. Match against one or more styles, or identify if it's a new style not in this list.

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

### Step 1: Analyze the Reference

If a URL was provided, use WebFetch to analyze the page. Extract as much as possible:

**Automatically Detectable:**
- [ ] Color palette (primary, secondary, accent, background, text colors - exact hex values)
- [ ] Typography (font families, sizes, weights, line heights)
- [ ] CSS framework detected (Tailwind classes, Bootstrap, custom)
- [ ] Component library hints (shadcn, Radix, Headless UI, Vuetify, Nuxt UI, PrimeVue)
- [ ] Border radius values
- [ ] Shadow styles
- [ ] Spacing patterns
- [ ] Layout system (grid type, container widths)

**Visually Identified:**
- [ ] Dark/Light mode preference
- [ ] Information density (compact/spacious)
- [ ] Visual hierarchy approach
- [ ] Icon style (outlined, filled, duotone, custom illustrations)
- [ ] Image treatment (rounded, sharp, overlapping, contained)
- [ ] Animation/transition style

### Step 2: Match Against Style Reference Database

**CRITICAL STEP:** Compare your findings against the UI Design Styles Reference Database above.

Determine:
1. **Primary Style Match:** Which style from the database best describes this URL? (Pick 1)
2. **Secondary Style Influences:** What other styles from the database are present? (Pick 0-3)
3. **Confidence Level:** How well does it match? (Strong match / Partial match / Weak match)

**If NO style matches well:**
- Describe the unique characteristics that don't fit existing categories
- Propose a NEW style name and definition
- Ask the user: "This appears to be a style not in my reference database. I'd call it **[Proposed Name]** characterized by [characteristics]. Should I add this to the style reference for future use?"

Present the style matching like this:

```markdown
## Style Classification

### Primary Style: [Style Name]
**Confidence:** [Strong/Partial/Weak]
**Matching characteristics:**
- [bullet points of what matches]

### Secondary Influences:
- **[Style Name]:** [which elements match]
- **[Style Name]:** [which elements match]

### Deviations from Standard:
- [What differs from the matched style's typical implementation]
```

### Step 3: Present Full Findings

Show the user what you found:

```markdown
## Extracted Style Specification

### Style Classification
[From Step 2]

### Colors
| Role | Hex | Usage |
|------|-----|-------|
| Primary | #xxx | |
| Secondary | #xxx | |
| Accent | #xxx | |
| Background | #xxx | |
| Surface | #xxx | |
| Text | #xxx | |
| Text Muted | #xxx | |
| Border | #xxx | |

### Typography
- Headings: [Font Family], weights used: [...]
- Body: [Font Family], base size: [...]
- Mono/Code: [Font Family]

### Framework/Libraries Detected
- CSS: [Tailwind / Bootstrap / UnoCSS / Custom]
- Components: [Detected library or "Unknown"]
- Icons: [Detected or "Unknown"]

### Measurements
- Border radius: [values observed]
- Base spacing unit: [estimated]
- Container max-width: [value]
- Shadows: [description]

### Layout Pattern
- [Description of layout approach]
```

### Step 4: Interactive Clarification

After presenting findings, ASK the user about:

1. **Style Confirmation:**
   - "I classified this as **[Style]** with **[Secondary]** influences. Does that match your intent, or are you aiming for something different?"
   - If new style proposed: "Should I add **[Proposed Style]** to the reference database?"

2. **Missing Information:**
   - "I couldn't detect the icon library. Do you want: Lucide, Heroicons, Phosphor, Tabler, or custom SVGs?"
   - "The component library isn't clear. For Nuxt, would you prefer: Nuxt UI, shadcn-vue, Radix Vue, PrimeVue, or Headless UI?"

3. **Contradictions or Choices:**
   - "The site uses both sharp and rounded corners. Which do you prefer?"
   - "I see both card-based and list layouts. What's your primary content display preference?"

4. **Deeper Style Questions:**
   - "How should loading states appear? (Skeletons / Spinners / Shimmer / None)"
   - "What's your button interaction style? (Scale / Color shift / Shadow lift / Ripple)"
   - "Empty states: Illustrated / Minimal text / Call-to-action focused?"
   - "Form style: Floating labels / Stacked / Inline / Bordered inputs?"
   - "Navigation pattern: Sidebar / Top bar / Command palette / Breadcrumbs?"

5. **Additional References:**
   - "Do you have additional URLs or screenshots to reference?"
   - "Any specific pages/apps whose [tables/forms/dashboards/etc.] you'd like to emulate?"

6. **Anti-Patterns:**
   - "What should this NOT look like? Any styles from the reference to explicitly avoid?"

### Step 5: Generate Final Specification

After gathering all input, produce a complete specification file:

```markdown
# UI Style Specification: [Project Name]

## Design Direction
- **Primary Style:** [Style from database]
- **Secondary Influences:** [Other styles]
- **Inspiration:** [URLs/products referenced]
- **Mood:** [2-3 descriptive words]

## Style Reference
> [Brief description of the primary style from the database, so future readers understand the intent]

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
- Primary: [main reference URL]
- Additional: [other URLs provided]

## Notes
[Any additional context or decisions made during specification]
```

### Step 6: Handle New Style Additions

If the user confirms a new style should be added, tell them:

"To add **[New Style Name]** to the reference database, add this entry to `~/.claude/commands/ui/create-style-from-url.md` in the appropriate category table:

```markdown
| **[New Style Name]** | [Key characteristics] | [Example products] |
```

I recommend adding it to the **[suggested category]** section."

### Step 7: Offer Next Steps

Ask the user:
- "Should I save this specification to a file in your project? (e.g., `docs/ui-style-spec.md` or `UI_STYLE.md`)"
- "Want me to generate a Tailwind config (`tailwind.config.ts`) based on these values?"
- "Should I create a CSS variables file for these tokens?"
- "Should I create example components demonstrating this style?"
