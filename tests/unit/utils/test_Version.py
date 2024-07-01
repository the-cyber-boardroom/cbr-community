from unittest import TestCase

from osbot_utils.utils.Files import file_name, folder_name, parent_folder

import cbr_community
from cbr_community.utils.Version import Version, version


class test_Version(TestCase):

    @classmethod
    def setUpClass(cls):
        cls.version = Version()

    def test_path_code_root(self):
        assert self.version.path_code_root() == cbr_community.path

    def test_path_version_file(self):
        with self.version as _:
            assert parent_folder(_.path_version_file()) == cbr_community.path
            assert file_name    (_.path_version_file()) == 'version'

    def test_value(self):
        assert self.version.value() == version