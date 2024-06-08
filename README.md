# Kanban Board

An open-source Kanban board application built with Flutter that allows you to manage your tasks and projects.

### Architecture Diagram:


### Folder Structure:

- lib
    - application
        - constants
        - core
            - base
            - exceptions
            - extensions
            - helpers
            - logger
            - themes
            - usecases
        - main_config
        - network
            - client
            - external_values
            - interceptors
            - network_helper
        - services
  - data
    - models
    - remote_data_src
    - repo_impl
  - di
  - domain
      - entities
      - repo_interfaces
      - use_cases
  - view
      - bloc
      - board_view
        - models
        - widgets
    - completed_tasks
        - models
        - widgets


_Note_: This is my current approach with clean architecture:


## Features

- A kanban board for tasks, where users can create, edit, and move tasks between different columns (e.g. "To Do", "In Progress", "Done").
- A timer function that allows users to start and stop tracking the time spent on each task
- A history of completed tasks, including the time spent on each task and the date it was completed.
- Users should be able to Comment on each task


Give a ⭐️ if you like the project.. Thanks!