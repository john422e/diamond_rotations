import csv
from pdf2image import convert_from_path, convert_from_bytes
from pdf2image.exceptions import (
    PDFInfoNotInstalledError,
    PDFPageCountError,
    PDFSyntaxError
)


def convertPDF_toPNG(directory, read_file, write_file=None, sep_output_folder=False):
    if sep_output_folder:
        output_directory = directory = 'pngs/'
    else:
        output_directory = directory
    if not write_file:
        write_file = read_file[:-4]
    image = convert_from_path(directory + read_file, fmt="png", single_file=True, output_file=write_file, output_folder=output_directory)

def output_csv(filename, array):
    with open(filename, 'w', newline='') as csvfile:
        csvwriter = csv.writer(csvfile, delimiter=',', quotechar='|',
                        quoting=csv.QUOTE_MINIMAL)
        for row in array:
            csvwriter.writerow(row)
