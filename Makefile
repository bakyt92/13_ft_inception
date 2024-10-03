name = ft_inception
#for ubuntu
DATA_DIR		=	$(HOME)/data
# for macos 
#DATA_DIR		=	/Users/ufitzhug/data

create_dirs:
	@echo "\e[36mCreating the volumes (dirs) at $(DATA_DIR)\e[0m"
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress

all: create_dirs
	@echo "Launch configuration ${name}...\n"
	@docker compose -f srcs/docker-compose.yml up -d

build: create_dirs
	@echo "Building configuration ${name}...\n"
	@docker compose -f srcs/docker-compose.yml up -d --build

down:
	@echo "Stopping configuration ${name}...\n"
	@docker compose -f srcs/docker-compose.yml down

re:	down
	@echo "Rebuild configuration ${name}...\n"
	@docker compose -f srcs/docker-compose.yml up -d --build

clean: down
	@echo "Cleaning configuration ${name}...\n"
	@docker system prune -a

fclean: down
	@echo "Total clean of all configurations docker\n"
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --all --force
	@docker volume rm srcs_db-volume
	@docker volume rm srcs_wp-volume

.PHONY	: all build down re clean fclean