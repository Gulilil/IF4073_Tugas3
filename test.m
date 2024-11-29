addpath("src\shape_detection\");
addpath("src\edge_detection\");

img = imread("img_test\road_1.jpg");
[edge_detected, parameter_domain, inversed_detected_image, shape_detected_image] = circle_detection(img, 0.95, [], [], [], "Canny", 30);

