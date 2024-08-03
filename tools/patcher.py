import sys


class Patcher:
    def __init__(self, target_filename, lines_to_delete, patch_filename):
        self.target_filename = target_filename
        self.patch_filename = patch_filename
        try:
            self.lines_to_delete = int(lines_to_delete)
        except ValueError:
            self.lines_to_delete = 0

        self.target_data = self.load_file(self.target_filename)

        self.patch_data = self.load_file(self.patch_filename)
        self.patch_trim_starting_newline()

        self.patch_start = self.patch_find_start()

    def patch_insert_lines(self, position=None):
        if position:
            self.target_data[position:position] = self.patch_data
        return

    def patch_delete_lines(self, start=None, number=0):
        if start and number:
            del self.target_data[start:start + number]
        return

    def patch_find_start(self):
        try:
            return self.target_data.index(self.patch_data[0])
        except ValueError:
            pass
        return None

    def patch_trim_starting_newline(self):
        if self.patch_data[0] == '\n':
            del self.patch_data[0]
            self.patch_trim_starting_newline()
        return

    def save_file(self, filename):
        with open(filename, 'w') as f:
            f.write(''.join(self.target_data))

    @staticmethod
    def load_file(filename):
        with open(filename, 'r') as f:
            d = f.readlines()
        return d

    def __repr__(self):
        return f't: {self.target_filename} <= p: {self.patch_filename}'

    def __str__(self):
        return f't: {self.target_filename} <= p: {self.patch_filename}'


if __name__ == '__main__':

    p = Patcher(
        target_filename=sys.argv[1],
        lines_to_delete=sys.argv[2],
        patch_filename=sys.argv[3],
    )
    if p.patch_start:
        p.patch_delete_lines(p.patch_start, p.lines_to_delete)
        p.patch_insert_lines(p.patch_start)
        p.save_file(p.target_filename)
