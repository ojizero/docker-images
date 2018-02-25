# Command Runner

Manages running our Node based CRON jobs.

## Build time arguements

`RUNNER`: The base image with the runner dependencies, this can be `node`, `php` or anything else. Default value `node`.
`VERSION`: The require base image version. Default value `9`.
`FLAVOUR`: The distro on which the base image is built from. Default value `stretch`.
`TAG`: The exact tag for the `RUNNER` base image. Default value `${VERSION}-${FLAVOUR}`.

## Run time variables

`STAGE`: The stage of the running CRON, if it's not `prod` or `production` the command is run only once. Default value `development`.
`APP_DIR`: The directory inside the container to run the command in. Default value `/opt/app`.
`APP_USER`: The user inside the container to run the command in. Default value `root`.
`CRON_SPEC`: The schedule for the CRON, using the standard CRON notation. Default value `* * * * *`.
`CRON_EXEC`: The command to be executed on the schedule, it has to be provided otherwise an error is thrown when running the image.
`EXEC_OPTS`: Any addition options the command needs. Default value is empty.
