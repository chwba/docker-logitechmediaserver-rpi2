### Docker Container for Logitech Media Server on LibreELEC / Raspberry Pi

This is a Docker image for running the Logitech Media Server package (Squeezebox) on an arm-based platform such as LibreELEC


To properly run it, creating a service is required (lms.service): 

    1. nano /storage/.kodi/addons/service.system.docker/examples/lms.service 
    2. systemctl enable /storage/.kodi/addons/service.system.docker/examples/lms.service
    3. systemctl start lms


The web interface runs on port 9000.

Thanks to larsks for his work, I just made some modifications.

https://hub.docker.com/r/peaceofmind/lms/
