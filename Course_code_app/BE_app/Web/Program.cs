using Application.Interfaces;
using Core.Interfaces;
using Infrastructure.Repositories;
using Application.Service;
using Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);
// builder.Services.AddScoped<IRoleService, RoleService>();
// builder.Services.AddScoped<IRoleRepository, RoleRepository>();
builder.Services.Scan(scan => scan
    .FromAssemblies(
        typeof(Application.Service.RoleService).Assembly,
        typeof(Infrastructure.Repositories.RoleRepository).Assembly,
        typeof(Application.Service.LoginServices).Assembly
    )
    .AddClasses(classes => classes.Where(type =>
        type.Name.EndsWith("Service") ||
        type.Name.EndsWith("Services")||
        type.Name.EndsWith("Repository")
        ))
    .AsImplementedInterfaces()
    .WithScopedLifetime()
);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

app.Run();