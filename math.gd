class_name Math


static func factorial(x: int) -> int:
	var mult: int = x
	for i in x - 1:
		mult *= x - 1 - i

	return mult


static func n_chooses_p(n: int, p: float) -> int:
	var mult: int = n
	for i in p - 1:
		mult *= n - i - 1

	return mult / factorial(p)


static func get_combinations(arr: Array, k: int) -> Array:
	if k == 0:
		return [[]]
	if k > arr.size():
		return []

	var result = []
	for i in range(arr.size()):
		var head = arr[i]
		var tail = arr.slice(i + 1, arr.size())

		for subset in get_combinations(tail, k - 1):
			result.append([head] + subset)

	return result
