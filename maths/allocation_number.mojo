"""
In a multi-threaded download, this algorithm could be used to provide
each worker thread with a block of non-overlapping bytes to download.
For example:
    for i in allocation_list:
        requests.get(url,headers={'Range':f'bytes={i}'})
"""

fn allocation_num(number_of_bytes: Int, partitions: Int) raises -> List[String]:
    """
    Divide a number of bytes into x partitions.
    :param number_of_bytes: the total of bytes.
    :param partitions: the number of partition need to be allocated.
    :return: list of bytes to be assigned to each worker thread

    >>> allocation_num(16647, 4)
    ['1-4161', '4162-8322', '8323-12483', '12484-16647']
    >>> allocation_num(50000, 5)
    ['1-10000', '10001-20000', '20001-30000', '30001-40000', '40001-50000']
    >>> allocation_num(888, 999)
    Error: partitions can not > number_of_bytes!
    >>> allocation_num(888, -4)
    Error: partitions must be a positive number!
    """
    if partitions <= 0:
        raise Error("partitions must be a positive number!")
    if partitions > number_of_bytes:
        raise Error("partitions can not > number_of_bytes!")
    var bytes_per_partition = number_of_bytes // partitions
    var allocation_list = List[String]()
    for i in range(partitions):
        var start_bytes = i * bytes_per_partition + 1
        var end_bytes = (
            number_of_bytes if i == partitions - 1 else (i + 1) * bytes_per_partition
        )
        allocation_list.append(str(start_bytes) + '-' + str(end_bytes))
    return allocation_list
