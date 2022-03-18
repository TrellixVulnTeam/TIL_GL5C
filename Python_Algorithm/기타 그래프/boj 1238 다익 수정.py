import sys
import heapq

N, M, X = map(int, sys.stdin.readline().split())
graph = [[] for i in range(N+1)]

INF = 999999999
for m in range(M) :
    u, v, w = map(int, sys.stdin.readline().split())
    graph[u].append((v,w))

def ds(start, end, g) :
    heap = []
    check = [False]*(N+1)
    table = [INF]*(N+1)
    heapq.heappush(heap, (0, start))
    table[start] = 0
    while heap :
        w, e = heapq.heappop(heap)
        if check[e] == True :
            continue
        for i in graph[e] :
            edge, weight = i
            cost = w + weight
            if cost < table[edge] :
                table[edge] = cost
                heapq.heappush(heap, (cost, edge))
        check[e] = True
    print(table)
    return table[end]

ds(1,2,graph)
ds(2,3,graph)
ds(3,2,graph)
ds(4,2,graph)

print('---')
answer = []

for n in range(1, N+1) :
    if n == X :
        continue
    answer.append(ds(n, X, graph) + ds(X, n, graph))
