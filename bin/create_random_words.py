"""
Create a text file with random words of `max_freq` lines
which is 600 here. Each line contains the same random words.
"""

import numpy as np
from RandomWordGenerator import RandomWord


max_freq = 600
word_counts = np.floor(max_freq / np.arange(1, max_freq + 1))
rw = RandomWord()
random_words = rw.getList(num_of_words=max_freq)
with open('test_data/random_words.txt', 'w') as writer:
    for index in range(max_freq):
        count = int(word_counts[index])
        word_sequence = f"{random_words[index]} " * count
        writer.write(word_sequence + '\n')