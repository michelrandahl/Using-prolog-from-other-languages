import jsonrpclib


server = jsonrpclib.Server('http://localhost:5000/handle')

testInput = {}
testInput[15] = 3
testInput[17] = 8
testInput[18] = 5
testInput[21] = 1
testInput[23] = 2
testInput[31] = 5
testInput[33] = 7
testInput[39] = 4
testInput[43] = 1
testInput[47] = 9
testInput[55] = 5
testInput[62] = 7
testInput[63] = 3
testInput[66] = 2
testInput[68] = 1
testInput[77] = 4
testInput[81] = 9

query = "sudoku(["
for x in range(9):
    query += "["
    for y in range(1,10):
        i = x*9 + y
        if i in testInput:
            query += str(testInput[i])
        else:
            query += "_" + str(i)
        if y < 9:
            query += ","
    query += "]"
    if x < 8:
        query += ","
query += "])"
print query
print "res: ", server.eval(query)

print jsonrpclib.history.request
