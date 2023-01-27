<?php

namespace App\Helpers;

trait Functions
{
    protected function explodeAndPop(string $str, string $delimiter = ' ') {
        $arr = explode($delimiter, $str);
        return array_pop($arr);
    }

    protected function getFileExtension(string $filename) {
        return $this->explodeAndPop($filename, '.');
    }

    protected function removeSpecialCharacters(string $str, string $replacement) {
        return preg_replace('/[^A-Za-z0-9]+/i', $replacement, $str);
    }

    protected function concatFilenameWithEmail(string $prefix, string $email, string $filename) {
        return $prefix . $this->removeSpecialCharacters($email, '_') . '.' . $this->getFileExtension($filename);
    }
}
