# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.app = {}

app.e_i = [1, 8, 15, 22, 29, 36, 43, 50, 57, 64]
app.s_n = [2, 3, 9, 10, 16, 17, 23, 24, 30, 31, 37, 38, 44, 45, 51, 52, 58, 59, 65, 66]
app.t_f = [4, 5, 11, 12, 18, 19, 25, 26, 32, 33, 39, 40, 46, 47, 53, 54, 60, 61, 67, 68]
app.j_p = [6, 7, 13, 14, 20, 21, 27, 28, 34, 35, 41, 42, 48, 49, 55, 56, 62, 63, 69, 70]

app.e = 0
app.i = 10
app.s = 0
app.n = 20
app.t = 0
app.f = 20
app.j = 0
app.p = 20

app.score = (q, answer_a) ->
  if q in app.e_i and answer_a is true
    app.e += 1
    app.i -= 1
  else if q in app.s_n and answer_a is true
    app.s += 1
    app.n -= 1
  else if q in app.t_f and answer_a is true
    app.t += 1
    app.f -= 1
  else if q in app.j_p and answer_a is true
    app.j += 1
    app.p -= 1

app.personality_type = (e, i, s, n, t, f, j, p) ->
  [gon.e, gon.i, gon.s, gon.n, gon.t, gon.f, gon.j, gon.p] = [e, i, s, n, t, f, j, p]
  type = []
  if e>i then type.push("E") else type.push("I")
  if s>n then type.push("S") else type.push("N")
  if t>f then type.push("T") else type.push("F")
  if j>p then type.push("J") else type.push("P")
  return type