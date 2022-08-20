(() => {
  "use strict";

  const HIS = ['greetings', 'aloha', 'yo', 'hi', 'hello', 'howdy', 'sup'];
  const COLORS = Array.from({ length: 8 }, (_, i) => `c${i}`);
  const css = (path) => `tr[data-path="${path}"] .data`;
  const pick = (a) => a[Math.floor(Math.random() * a.length)];
  const hi = (version) => `${pick(HIS)} from ${version}`;
  const tick = ($, path, v) => {
    $(css(path)).text(hi(v)).removeClass(COLORS.join(' ')).addClass(pick(COLORS));
  };

  document.addEventListener('DOMContentLoaded', () => {
    const scripts = Array.from(document.querySelectorAll('table tbody tr')).map(el => {
      const path = el.dataset.path;

      let script = document.createElement('script');
      script.onload = () => {
        let jq = window.$.noConflict();
        const v = jq.fn.jquery;
        jq(css(path)).attr('title', v);
        tick(jq, path, v);
        setInterval(() => { tick(jq, path, v); }, 500 + Math.random() * 5000);
      };
      script.src = path;

      return script;
    });

    document.head.append(...scripts);
  });
})();
