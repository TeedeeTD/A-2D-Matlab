% input maze
maze = true(30, 30);
num_obstacles = 500;  % Number of obstacles
solanlap = 10;  % Number of iterations
% define the start and end points
n = 5; 
m = 22;
start_coords = [1, n];
dest_coords = [30, m];

% create a random path from the start point to the end point
current_coords = start_coords;
path = [];  % Store the path
while ~isequal(current_coords, dest_coords)
    maze(current_coords(1), current_coords(2)) = false;
    path = [path; current_coords];  % Add the current coordinates to the path

    % Randomly select the next direction
    directions = [0, 1; 1, 0; 0, -1; -1, 0];
    direction = directions(randi(4), :);

    % Update the current coordinates
    current_coords = current_coords + direction;

    % Ensure that the current coordinates do not go out of bounds
    current_coords = max(min(current_coords, size(maze)), 1);
end

% chay AStar
% run AStar
dest_coords_new = dest_coords - [1 0];
[route, numExpanded] = AStarGrid (maze, start_coords, dest_coords_new);

% create a new maze
for k = 1:solanlap 
    for i = 1:num_obstacles 
        obstacle_coords_i = [randi(size(maze, 1)), randi(size(maze, 2))];
        maze(obstacle_coords_i(1), obstacle_coords_i(2)) = true;
        maze(route) = false;
    end
    for j = 1:num_obstacles 
        obstacle_coords_j = [randi(size(maze, 1)), randi(size(maze, 2))];
        maze(obstacle_coords_j(1), obstacle_coords_j(2)) = false; 
        maze(route) = false;
    end
    
    %**create the frame**
    %plank
    maze(1:end-1,1) = true; maze(1:end-1,31) = true;
    %top
    maze(1,1:(n-1)) = true; maze(1,(n+1):end) = true;
    %blow
    maze(end,1:(m-1)) = true;
    maze(end,(m+1):end) = true;
    maze(route) = false;

    % you can run AStar to see the changes
    %[route, numExpanded] = AStarGrid (maze, start_coords, dest_coords);
end

% display the created maze
disp(maze)
close all;

% run Astar
[route, numExpanded] = AStarGrid (maze, start_coords, dest_coords);

% Save the maze into a file 'maze.mat'
save('maze.mat', 'maze');
% Save the path coordinates into a file 'path.mat'
save('path.mat', 'path');
% Create a maze from the file 'maze.mat'
load('maze.mat');
% Load the path coordinates from the file 'path.mat'
load('path.mat');
