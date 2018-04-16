# Sorting_algorithms
Visualization of various sorting algorithms (e.g. bubble sort, insertion sort) on a randomized matrix of RGB values. Can also input your own image. Code is organized by a variety of functions.

Note that images are sorted by perceived brightness using the following equation on the RGB values of each pixel:

pixel_Brightness = sqrt(0.299*(pixel_Rvalue).^2 + 0.587*(pixel_Gvalue).^2 + 0.114*(pixel_Bvalue).^2);


To run, navigate to the sort_select file in your MATLAB directory. 

Run as a function: sort_select(do_sort,random_matrix), where do_sort is the name of a sorting algorithm.

Currently do_sort can be 'bubble_sort', 'insertion_sort', selection_sort', or 'brick_sort'.

Random_matrix should either be 1 or 0. 1 specifies a random colour matrix (parameters in the sort_select file). If 0, a .jpg is selected as the input image for visualization (filename should be adjusted in sort_select). 

Note that selection_sort is the fastest due to the way MATLAB draws plots and uses for loops. Future versions will include 
divide and conquer algorithms. 
