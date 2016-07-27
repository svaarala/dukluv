"use strict";

var utils = require('./modules/utils.js');
var p = utils.prettyPrint;

function Timer() {
  var obj = Object(uv.new_timer());  // coerce to ArrayBuffer
  obj.__proto__ = Timer.prototype;
  return obj;
}

Timer.prototype.start = uv.timer_start;
Timer.prototype.stop = uv.timer_stop;

uv.read_start(utils.stdin, function (err, chunk) {
  if (err) { throw err; }
  if (!chunk) { return uv.read_stop(utils.stdin); }
  try {
    if (Duktape.version >= 19999) {
      p(eval(String.fromBuffer(chunk)));
    } else {
      p(eval(chunk.toString()));
    }
  }
  catch (error) {
    uv.write(utils.stderr, utils.colorize("error", error.toString()) + "\n");
  }
  uv.write(utils.stdout, "> ");
});
uv.write(utils.stdout, "> ");

uv.run();

uv.write(utils.stdout, "\n");
