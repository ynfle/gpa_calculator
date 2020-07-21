import json, sequtils, tables

type
  FinalGrade* = tuple
    credits: int
    grade: string
  Gpa* = seq[FinalGrade]

let ninePointGpa = {
  "A+": 9,
  "A": 8,
  "B+": 7,
  "B": 6,
  "C+": 5,
  "C": 4,
  "D+": 3,
  "D": 2,
  "E": 1,
  "F": 0
}.toTable

let fourPointGpa = {
  "A+": 4,
  "A": 4,
  "A-": 3,
  "B+": 3,
  "B": 3,
  "B-": 2,
  "C+": 2,
  "C": 2,
  "C-": 1,
  "D+": 1,
  "D": 1,
  "E": 0,
  "F": 0
}.toTable

template calculateGpa(data: GPA, scale: untyped, skipGrade: seq[string] = @[]): float =
  data.foldl(a + b.credits * `scale PointGpa`[b.grade], 0) / data.foldl(a + b.credits, 0)
# proc calculate9GPa(data: Gpa, skipGrades: seq[string] = @[]): float =
#   data.foldl(a + b.credits * ninePointGpa[b.grade], 0) / data.foldl(a + b.credits, 0)


# proc calculate4GPa(data: Gpa, skipGrades: seq[string] = @[]): float =
#   data.foldl(a + b.credits * fourPointGpa[b.grade], 0) / data.foldl(a + b.credits, 0)



var tomoJsonData = parseFile "./data/tomo.json"

var yorkuJsonData = parseFile "data/yorku.json"

let yorkuData = yorkuJsonData.to(Gpa)
let tomoData = tomoJsonData.to(Gpa)
# echo yorkuData.calculateGpa(four)
echo yorkuData.filterIt(it.grade notin @["F", "E", "D", "D+"]).calculateGPa nine
echo tomoData.calculateGPa nine
echo calculateGpa(tomoData & yorkuData, nine)
echo calculateGpa(tomoData & yorkuData.filterIt(it.grade notin @["F", "E", "D", "D+"]), four)
