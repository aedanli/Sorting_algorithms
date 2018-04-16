# Sorting_algorithms
Visualization of various sorting algorithms (e.g. bubble sort, insertion sort) on a randomized matrix of RGB values. Can also input your own image.

To run, navigate to the sort_select file in your MATLAB directory. 

Run as a function: sort_select(do_sort,random_matrix), where do_sort is the name of a sorting algorithm.

Currently sort_select can be 'bubble_sort', 'insertion_sort', selection_sort', and 'brick_sort'.

Random_matrix should either be 1 or 0, if 1 then specify a random colour matrix (parameters in the sort_select file). If 0, input a .jpg
as the image (filename should be adjusted in sort_select). 

Note that selection_sort is the fastest due to the way MATLAB draws plots and uses for loops. Future versions will include 
divide and conquer algorithms. 
