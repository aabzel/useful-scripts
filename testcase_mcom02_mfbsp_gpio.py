#!/usr/bin/env python2

# Copyright 2017 RnD Center "ELVEES", JSC
#

# In order to perform GPIO test
# connect XP5 pins according the table
# LACK (0) - LDAT3 (5)
# LCLK (1) - LDAT4 (6)
# LDAT0(2) - LDAT5 (7)
# LDAT1(3) - LDAT6 (8)
# LDAT2(4) - LDAT7 (9)

import unittest

import libfc

GATE_SYS_CTR = '0x3809404C'
DIR_MFBSP = '0x38088008'
GPIO_DR = '0x3808800C'
CSR_MFBSP = '0x38088004'

LEN_BIT = 0
SPI_I2S_EN_BIT = 9
MFBSP1_EN_BIT = 9

def setbit(val, bit):
    return val | (1 << bit)

def resetbit(val, bit):
    return val & (~(1 << bit))

HIGH = 1
LOW = 0

class TestcaseMFBSP1GPIO(libfc.TestCaseLinuxUART):

    def read(self, addr):
        return int(self.dut.run("devmem {}".format(addr)), 16)

    def write(self, addr, val):
        self.dut.run("devmem {} w {:#x}".format(addr, val))

    def check(self, driver, monitor):
        self.gpio_set_dir(driver, output=True)
        self.gpio_set_dir(monitor, output=False)
        self.gpio_set(driver, 0)
        self.assertEqual(self.gpio_get(monitor),
                         0, "Levels do not match driver:{} monitor:{} level:0".format(driver,
                                                                                      monitor))
        self.gpio_set(driver, 1)
        self.assertEqual(self.gpio_get(monitor),
                         1, "Levels do not match driver:{} monitor:{} level:1".format(driver,
                                                                                      monitor))

    def set_gpio_mode(self):
        csr = self.read(CSR_MFBSP)
        csrnew = resetbit(resetbit(csr, LEN_BIT), SPI_I2S_EN_BIT)
        self.write(CSR_MFBSP, csrnew)

    def gpio_set_dir(self, pin, output):
        dirreg = self.read(DIR_MFBSP)
        if output:
            dirreg = setbit(dirreg, pin)
        else:
            dirreg = resetbit(dirreg, pin)
        self.write(DIR_MFBSP, dirreg)

    def gpio_set(self, pin, level):
        regVal = self.read(GPIO_DR)
        if level == HIGH:
            regVal = setbit(regVal, pin)
        else:
            regVal = resetbit(regVal, pin)
        self.write(GPIO_DR, regVal)

    def gpio_get(self, pin):
        dr = self.read(GPIO_DR)
        return (dr >> pin) & 1

    def teststep_check_gpio(self):
        'MFBSP1 GPIO'
        " TODO: checking GPIO should be redone -"
        " all GPIO pairs must checked simulteneously while running hot one"
        for a, b in (0, 5), (1, 6), (2, 7), (3, 8), (4, 9):
            self.check(a, b)
            self.check(b, a)

    def tearDown(self):
        # disable MFBSP1 clock
        self.write(GATE_SYS_CTR, self.read(GATE_SYS_CTR) & (~(1 << MFBSP1_EN_BIT)))
        # TODO should restore all MFBSP registers to default state

    def setUp(self):
        # enable MFBSP1 clock
        self.write(GATE_SYS_CTR, self.read(GATE_SYS_CTR) | (1 << MFBSP1_EN_BIT))
        self.set_gpio_mode()

if __name__ == '__main__':
    unittest.main(verbosity=2)
