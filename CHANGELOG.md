Changelog
=========

## x.y.z - UNRELEASED

--------

## 0.3.2 - 2007-10-08

### Fixed

* The framework no longer removes error messages from the job log.

--------

## 0.3.1 - 2007-09-30

### Fixed

* Replaced all exclamation marks (!) by a simple dot (.), to avoid transcoding problem between different locales and different platforms.

--------

## 0.3 - 2007-09-29

### Fixed

* Fixed RPGUnit's acceptance tests so that they pass when submitted from a server job (e.g., using RMTCMD).
* Fixed RUCALLTST completion message so that the words are suffixed by 's' only if there are several of them.
* Fixed fail() so that calling it from inside a monitor block actually raises an exception outside the monitor block. Until then, calling fail() from inside a monitor block would only force a jump to the on-error part of the block.

### Added

* Added online help for commands RUCRTTST and RUCALLTST.
* RUCALLTST command sends status messages during test execution.
* RUCRTTST command gives a completion message when it ends successfully.
* RUCALLTST command generates spool files with more helpful names than QSYSPRT. The spool file name is RPGUNIT and its associated user data is the name of the test program.

### Changed

* Changed PGM parameter for RUCRTTST command to TSTPGM, to be consistent with RUCALLTST command.
* If the setUpSuite procedure raises an error, RUCALLTST command tries to execute the tearDownSuite procedure anyway before ending. That way, the clean-up activities in tearDownSuite get a chance to run.
* Also, an error during setUpSuite is no longer a special case. It is simply reported in the spool file, like any error raised during a test run. Same for tearDownSuite.

--------

## 0.2 - 2006-09-05

### Added

* Uploaded source code to sourceforge.
