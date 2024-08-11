% tao ra map
maze = true(30, 30);
num_obstacles = 500;  % so luong chuong ngai vat
solanlap = 10;
%dinh nghia diem dau va diem ket thuc
n = 5; 
m = 22
start_coords = [1, n];
dest_coords = [30, m];

% tao mot duong di ngau nhien tu diem bat dau den diem ket thuc
current_coords = start_coords;
path = [];  % Luu tru duong di
while ~isequal(current_coords, dest_coords)
    maze(current_coords(1), current_coords(2)) = false;
    path = [path; current_coords];  % Them toa do hien tai vao duong di

    % Chon ngau nhien mot huong tiep theo
    directions = [0, 1; 1, 0; 0, -1; -1, 0];
    direction = directions(randi(4), :);

    % Cap nhat toa do hien tai
    current_coords = current_coords + direction;

    % dam bao rang toa do hien tai khong vuot ra khoi me cung
    current_coords = max(min(current_coords, size(maze)) , 1);
end
% chay AStar
dest_coords_new = dest_coords - [1 0]
[route, numExpanded] = AStarGrid (maze, start_coords, dest_coords_new);

%tao me cung moi
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

%**tao khung**
%plank
maze(1:end-1,1)=true;maze(1:end-1,31)=true;
%top
maze(1,1:(n-1))=true;maze(1,(n+1):end)=true;
%blow
maze(end,1:(m-1))=true;
maze(end,(m+1):end)=true;
maze(route) = false;
% co the chay AStar xem su bien doi
%%[route, numExpanded] = AStarGrid (maze, start_coords, dest_coords);
end

% in ra me cung da tao duoc
disp(maze)
close all;

% run Astar
[route, numExpanded] = AStarGrid (maze, start_coords, dest_coords);
% Luu maze vào file 'maze.mat'
save('maze.mat', 'maze');

% Luu toa do duong di vào file 'path.mat'
save('path.mat', 'path');

% Tao maze tu file 'maze.mat'
load('maze.mat');

% Tai toa do duong di tu file 'path.mat'
load('path.mat');

