(() => {
  "use strict";

  // greeting phrases
  const HIS = ['greetings', 'aloha', 'yo', 'hi', 'hello', 'howdy', 'sup'];

  // color classes (c0 .. c7, defined in style.css)
  const COLORS = Array.from({ length: 8 }, (_, i) => `c${i}`);

  // return random array element
  const pick = (a) => a[Math.floor(Math.random() * a.length)];

  // convert given script file path to css selector.
  const css = (path) => `tr[data-path="${path}"] .data`;

  // generate random greeting for given version string.
  const hi = (version) => `${pick(HIS)} from ${version}`;

  // use the given jquery to update color and greeting for the
  // corresponding row.  called from setInterval() below to create an
  // obnoxious animation
  const tick = ($, path, v) => {
    $(css(path)).text(hi(v)).removeClass(COLORS.join(' ')).addClass(pick(COLORS));
  };

  document.addEventListener('DOMContentLoaded', () => {
    // 1. find <tr> elements with a data-path attribute
    // 2. use them to create and attach <script> elements
    // 3. the onload for attached <script> elements will do the
    //    following:
    //
    //    a. get a handle to the correct version of jquery
    //    b. set the title, text, and color of the row for the given
    //       version of jquery
    //    c. add an animation which refreshes the text and color with
    //       a random delay random delay in between 0.5 and 5 seconds,
    //       inclusive.
    const scripts = Array.from(document.querySelectorAll('table tr[data-path]')).map(el => {
      const path = el.dataset.path;

      // create script element
      let script = document.createElement('script');
      script.onload = () => {
        // get jquery and version string
        let jq = window.$.noConflict();
        const v = jq.fn.jquery;

        // set title, text, and color
        jq(css(path)).attr('title', v);
        tick(jq, path, v);

        // register animation
        setInterval(() => { tick(jq, path, v); }, 500 + Math.random() * 5000);
      };
      script.src = path;

      return script;
    });

    // append scripts to document header
    document.head.append(...scripts);
  });
})();
