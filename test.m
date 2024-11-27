addpath("src\shape_detection\");
addpath("src\edge_detection\");

img = imread("img_test\road_1.jpg");
[edge_detected, parameter_domain, shape_detected_image] = line_detection(img);

