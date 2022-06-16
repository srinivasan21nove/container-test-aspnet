# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ./ ./
RUN dotnet publish -c Release -o out

# Build runtime image
# FROM mcr.microsoft.com/dotnet/aspnet:6.0
# WORKDIR /app
# COPY --from=build-env /app/out .
# ENTRYPOINT ["dotnet", "MyWebApp.dll"]
FROM ubuntu
WORKDIR /install
RUN apt-get update -y
RUN apt-get install wget -y
RUN wget https://dot.net/v1/dotnet-install.sh
RUN chmod a+rwx dotnet-install.sh
RUN ./dotnet-install.sh -c Current --runtime aspnetcore
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["/root/.dotnet/dotnet", "MyWebApp.dll"]
