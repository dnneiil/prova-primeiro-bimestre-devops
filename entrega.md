\### docker compose ps



```

NAME                                        SERVICE    STATUS

prova-primeiro-bimestre-devops-api-1        api        Up 29 minutes

prova-primeiro-bimestre-devops-postgres-1   postgres   Up 29 minutes (healthy)

```



\### terraform plan



```

Plan: 14 to add, 0 to change, 0 to destroy.

```



\### API na AWS (RDS)



```

GET /health         -> {"status":"ok"}

POST /reservas      -> reserva criada (id 2)

GET /reservas       -> lista com as reservas gravadas no RDS

GET /reservas/2     -> HTTP 404 depois do DELETE

```

