from sys import argv
import random

#Based heavily on
#http://codereview.stackexchange.com/questions/69370/monte-carlo-pi-calculation

script, throws = argv
num_throws = int(throws)


def calculate_pi(throws):
    inside = 0
    for _ in range(throws):
        x, y = random.random(), random.random()
        if (((0.5 - x) ** 2) + ((0.5 - y) ** 2)) <= 0.25:
            inside += 1
    return (4.0 * inside) / throws

if __name__ == '__main__':
    print calculate_pi(num_throws)
