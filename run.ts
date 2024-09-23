// https://github.com/moonbitlang/moonbit-docs/blob/main/legacy/examples/wasm-gc/main.mjs
let memory: WebAssembly.Memory;

const [log, flush] = (() => {
  let buffer: number[] = [];
  function flush() {
    if (buffer.length > 0) {
      console.log(
        new TextDecoder("utf-16").decode(new Uint16Array(buffer).valueOf())
      );
      buffer = [];
    }
  }
  function log(ch: number) {
    if (ch == "\n".charCodeAt(0)) {
      flush();
    } else if (ch == "\r".charCodeAt(0)) {
      /* noop */
    } else {
      buffer.push(ch);
    }
  }
  return [log, flush];
})();

const importObject = {
  spectest: {
    print_char: log,
  },
  js_string: {
    new: (offset: number, length: number) => {
      const bytes = new Uint16Array(memory.buffer, offset, length);
      const string = new TextDecoder("utf-16").decode(bytes);
      return string;
    },
    empty: () => {
      return "";
    },
    log: (string: string) => {
      console.log(string);
    },
    append: (s1: string, s2: string) => {
      return s1 + s2;
    },
  },
};
const obj: any = await WebAssembly.instantiateStreaming(
  fetch(
    new URL(
      "target/wasm-gc/release/build/main-wasm/main-wasm.wasm",
      import.meta.url
    )
  ),
  importObject
);
memory = obj.instance.exports["moonbit.memory"];
obj.instance.exports._start();
flush();
