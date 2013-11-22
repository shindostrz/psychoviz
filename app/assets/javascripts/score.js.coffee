# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.app = {}
# app.all_qs = [1..70]
app.e_i = [1, 8, 15, 22, 29, 36, 43, 50, 57, 64]
app.s_n = [2, 3, 9, 10, 16, 17, 23, 24, 30, 31, 37, 38, 44, 45, 51, 52, 58, 59, 65, 66]
app.t_f = [4, 5, 11, 12, 18, 19, 25, 26, 32, 33, 39, 40, 46, 47, 53, 54, 60, 61, 67, 68]
app.j_p = [6, 7, 13, 14, 20, 21, 27, 28, 34, 35, 41, 42, 48, 49, 55, 56, 62, 63, 60, 70]

app.e = 0
app.s = 0
app.t = 0
app.j = 0

app.score = (q, answer_a) ->
  if $.inArray(q, app.e_i) != -1
    if answer_a = true
      app.e += 1
      app.i = 10 - app.e
  else if $.inArray(q, app.s_n) != -1
    if answer_a = true
      app.s += 1
      app.n = 20 - app.s
  else if $.inArray(q, app.t_f) != -1
    if answer_a = true
      app.t += 1
      app.f = 20 - app.t
  else if $.inArray(q, app.j_p) != -1
    if answer_a = true
      app.j += 1
      app.p = 20 - app.j




