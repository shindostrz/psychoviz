# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

all_qs = [1..70]
e_i = [1, 8, 15, 22, 29, 36, 43, 50, 57, 64]
s_n = [2, 3, 9, 10, 16, 17, 23, 24, 30, 31, 37, 38, 44, 45, 51, 52, 58, 59, 65, 66]
t_f = [4, 5, 11, 12, 18, 19, 25, 26, 32, 33, 39, 40, 46, 47, 53, 54, 60, 61, 67, 68]
j_p = [6, 7, 13, 14, 20, 21, 27, 28, 34, 35, 41, 42, 48, 49, 55, 56, 62, 63, 60, 70]

quiz = (q, answer_a) ->
  if $.inArray(q, e_i) != -1
    if answer_a = true
      e += 1
    else
      i += 1
  else if $.inArray(q, s_n) != -1
    if answer_a = true
      s += 1
    else
      n += 1
  else if $.inArray(q, t_f) != -1
    if answer_a = true
      t += 1
    else
      f += 1
  else if $.inArray(q, j_p) != -1
    if answer_a = true
      j += 1
    else
      p += 1

q = 1
for q in all_qs
  quiz q answer_a
  q += 1



