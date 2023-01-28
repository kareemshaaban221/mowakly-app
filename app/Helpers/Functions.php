<?php

namespace App\Helpers;

Trait Functions
{
    public function explodeAndPop(string $str, string $delimiter = ' ') {
        $arr = explode($delimiter, $str);
        return array_pop($arr);
    }

    public function getFileExtension(string $filename) {
        return $this->explodeAndPop($filename, '.');
    }

    public function removeSpecialCharacters(string $str, string $replacement) {
        return preg_replace('/[^A-Za-z0-9]+/i', $replacement, $str);
    }

    public function concatFilenameWithEmail(string $prefix, string $email, string $filename) {
        return $prefix . $this->removeSpecialCharacters($email, '_') . '.' . $this->getFileExtension($filename);
    }
}
