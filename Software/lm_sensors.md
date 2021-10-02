# install and initial setting
```
[root@life1 02_ENCSR600ZHS]# yum install lm_sensors


[root@life1 02_ENCSR600ZHS]# sensors-detect
# sensors-detect revision 3.4.0-8 (2016-06-01)
# System: Dell Inc. PowerEdge R740xd2
# Board: Dell Inc. 0C2PJH
# Kernel: 3.10.0-1160.el7.x86_64 x86_64
# Processor: Intel(R) Xeon(R) Gold 5217 CPU @ 3.00GHz (6/85/7)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): Yes
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 16h thermal sensors...                           No
AMD Family 17h thermal sensors...                           No
AMD Family 15h power sensors...                             No
AMD Family 16h power sensors...                             No
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
Intel 5500/5520/X58 thermal sensor...                       No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): no

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no): no

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): no

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): no

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): no
To load everything that is needed, add this to one of the system
initialization scripts (e.g. /etc/rc.d/rc.local):

#----cut here----
# Chip drivers
modprobe coretemp
/usr/bin/sensors -s
#----cut here----

You really should try these commands right now to make sure everything
is working properly. Monitoring programs won't work until the needed
modules are loaded.


[root@life1]# sensors
coretemp-isa-0000
Adapter: ISA adapter
Package id 0:  +76.0°C  (high = +92.0°C, crit = +102.0°C)
Core 0:        +73.0°C  (high = +92.0°C, crit = +102.0°C)
Core 1:        +71.0°C  (high = +92.0°C, crit = +102.0°C)
Core 2:        +71.0°C  (high = +92.0°C, crit = +102.0°C)
Core 3:        +72.0°C  (high = +92.0°C, crit = +102.0°C)
Core 4:        +76.0°C  (high = +92.0°C, crit = +102.0°C)
Core 5:        +73.0°C  (high = +92.0°C, crit = +102.0°C)
Core 6:        +71.0°C  (high = +92.0°C, crit = +102.0°C)
Core 7:        +71.0°C  (high = +92.0°C, crit = +102.0°C)

coretemp-isa-0001
Adapter: ISA adapter
Package id 1:  +77.0°C  (high = +92.0°C, crit = +102.0°C)
Core 0:        +76.0°C  (high = +92.0°C, crit = +102.0°C)
Core 1:        +77.0°C  (high = +92.0°C, crit = +102.0°C)
Core 2:        +75.0°C  (high = +92.0°C, crit = +102.0°C)
Core 3:        +73.0°C  (high = +92.0°C, crit = +102.0°C)
Core 4:        +75.0°C  (high = +92.0°C, crit = +102.0°C)
Core 5:        +76.0°C  (high = +92.0°C, crit = +102.0°C)
Core 6:        +77.0°C  (high = +92.0°C, crit = +102.0°C)
Core 7:        +74.0°C  (high = +92.0°C, crit = +102.0°C)
```
