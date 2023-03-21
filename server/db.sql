create database chat;

create table users (
id varchar(36) primary key,
firstName varchar(20) not null,
lastName varchar(20) not null,
email varchar(50) not null unique,
password varchar(255) not null,
createdAt datetime not null default current_timestamp,
updatedAt datetime not null default current_timestamp
);

create table files (
id varchar(36) primary key,
name varchar(100) not null,
fileKey varchar(36) not null,
mime varchar(20) not null,
size int not null,
userId varchar(36) not null,
unique (userId, name),
foreign key (userId) references users(id),
createdAt datetime not null default current_timestamp,
updatedAt datetime not null default current_timestamp
);

create table userProfiles (
id varchar(36) primary key,
userId varchar(36) not null unique,
foreign  key (userId) references users(id),
bio varchar(200),
avatarId varchar(36) not null,
foreign key (avatarId) references files(id),
createdAt datetime not null default current_timestamp,
updatedAt datetime not null default current_timestamp
);

create table userTokens (
id varchar(36) primary key,
userId varchar(36) not null unique,
token varchar(255) not null unique,
createdAt datetime not null default current_timestamp,
updatedAt datetime not null default current_timestamp
);

create table contacts (
id varchar(36) primary key,
senderId varchar(36) not null,
foreign key (senderId) references users(id),
receiverId varchar(36) not null,
foreign key (receiverId) references users(id),
unique(senderId, receiverId),
unique(receiverId, senderId),
isActive int default 0,
check (isActive = 0 or isActive = 1),
createdAt datetime not null default current_timestamp,
updatedAt datetime not null default current_timestamp
);

create table rooms (
id varchar(36) primary key,
name varchar(100) not null,
ownerId varchar(36) not null,
foreign key (ownerId) references users(id),
createdAt datetime not null default current_timestamp,
updatedAt datetime not null default current_timestamp
);

create table participants (
id varchar(36) primary key,
userId varchar(36) not null,
foreign key (userId) references users(id),
roomId varchar(36) not null,
foreign key (roomId) references rooms(id),
unique(userId, roomId),
createdAt datetime not null default current_timestamp,
updatedAt datetime not null default current_timestamp
);


create table messages (
id varchar(36) primary key,
senderId varchar(36) not null,
foreign key (senderId) references users(id),
body varchar(200),
fileId varchar(36),
foreign key (fileId) references files(id),
roomId varchar(36) not null,
foreign key (roomId) references rooms(id)
);
