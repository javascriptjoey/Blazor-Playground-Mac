# Use the official SDK image as a build stage, 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the application inside the container
RUN dotnet restore
RUN dotnet build -c Release -o /app/build

# Run tests (replace with your actual test commands)
# RUN dotnet test

# Optionally, run linting (replace with your actual linting commands)
# RUN lint-command-here

# Build a smaller runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/build .

# Expose the port
EXPOSE 8080

# Define the entry point
ENTRYPOINT ["dotnet", "Blazor-Playground-Mac.dll", "--port", "8080"]