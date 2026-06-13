# UI Polish Checklist

Mark each item: ✅ Pass | ❌ Fail (component:issue) | N/A

---

## Visual quality

- [ ] All spacing values use a consistent scale (4px / 8px base grid)
- [ ] No magic numbers in CSS — all values are named tokens or variables
- [ ] Typography hierarchy is clear: heading → subheading → body → caption
- [ ] Color contrast ≥ 4.5:1 for normal text (WCAG AA)
- [ ] Color contrast ≥ 3:1 for large text and UI components (WCAG AA)
- [ ] No raw hex / RGB colors outside of `:root` or theme variables file
- [ ] Consistent use of border-radius, shadow, and transition values

---

## Interaction quality

- [ ] Every clickable element has a visible `hover` state
- [ ] Every focusable element has a visible `focus` / `focus-visible` ring
- [ ] Buttons show a `disabled` state when the action is unavailable
- [ ] Form validation errors appear inline (next to the field), not as alerts
- [ ] Links are visually distinct from body text
- [ ] Interactive elements do not rely solely on color to convey state

---

## States and edge cases

- [ ] Every async operation has a loading indicator (spinner, skeleton, or progress)
- [ ] Every list, table, or feed has an empty state with a helpful message
- [ ] Every operation that can fail shows a human-readable error message
- [ ] Form submissions show a success confirmation (toast, message, or redirect)
- [ ] Destructive actions (delete, reset) require a confirmation step

---

## Accessibility

- [ ] All images have descriptive `alt` text (or `alt=""` for decorative images)
- [ ] All form inputs have associated `<label>` elements
- [ ] Icon-only buttons have an `aria-label`
- [ ] Keyboard navigation works without a mouse (Tab, Enter, Escape, arrow keys)
- [ ] Modal dialogs trap focus and return focus on close
- [ ] Page has a single `<h1>` per view
- [ ] Heading hierarchy is logical (no skipped levels)
- [ ] Color is not the only means of conveying information

---

## Responsiveness

- [ ] Layout is correct at 375px viewport (mobile)
- [ ] Layout is correct at 768px viewport (tablet)
- [ ] Layout is correct at 1280px viewport (desktop)
- [ ] No horizontal scroll at any of the three breakpoints
- [ ] Touch targets are at least 44×44px on mobile
- [ ] Font sizes are readable at mobile (minimum 14px body text)

---

## Performance

- [ ] All `<img>` elements have explicit `width` and `height` attributes
- [ ] No render-blocking `<script>` in `<head>` without `defer` or `async`
- [ ] Images below the fold use `loading="lazy"`
- [ ] No unused CSS loaded on first paint
- [ ] Fonts are preloaded if they are critical to layout
