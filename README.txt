Arcanum site

1. This project depends on the anacleto project.

2. Dependencies are in the ISO/tools/apache-tomcat-5.5.23-embed/lib dir

3. ISO image building from ANT (windows):
3.1 istall cygwin
3.2 copy bin/mkisofs.exe in the {cywin.home}/bin directory
3.3 adjust build.properties
   a.) specify cygwin install dir
   b.) specify the iso.input variable to point to the ${basedir}/ISO directory
       this is a workaround to the problem, that in DOS the "Documents and Settings"
       cannot be interpreted as a directory
   c.) specify the index directory to put on the disk (it' has to be optimised
   d.) specify the j2sdk.dir variable to point to an j2sdk instance. 
   e.) specify the content directory to burn in the disk
3.4 run the ISO task that will produce an ISO image where the iso.output points
4. mount ISO image with the PowerISO program or other

