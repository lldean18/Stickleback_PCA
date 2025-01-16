import sys
import pandas as pd
import matplotlib.pyplot as plt
import os

def main():
    # Check if the script received the correct number of command-line arguments
    if len(sys.argv) != 2:
        print("Usage: python script.py <input_file>")
        sys.exit(1)
    
    # Get the input filename from the command-line arguments
    input_file = sys.argv[1]

    # Extract the plot title from the input filename
    base_filename = os.path.basename(input_file)  # Get the base filename (without the path)
    plot_title = base_filename.split("_")[-1].rsplit(".", 1)[0]  # Get the string between the last "_" and "."
    
    # Create the output PNG filename
    output_file = os.path.splitext(input_file)[0] + ".png"

    # Read the numbers from the input file into a Pandas DataFrame
    try:
        df = pd.read_csv(input_file, header=None, names=["Numbers"])
    except Exception as e:
        print(f"Error reading file {input_file}: {e}")
        sys.exit(1)

    # Check if the file contains numeric data
    if not pd.api.types.is_numeric_dtype(df["Numbers"]):
        print("The file does not contain numeric data.")
        sys.exit(1)

    # Plot a histogram of the numbers
    plt.figure(figsize=(10, 6))
    plt.hist(df["Numbers"], bins=300, color='blue', alpha=0.7)
    plt.title(f"Histogram of {plot_title}")
    plt.xlabel("Values")
    plt.ylabel("Frequency")
    plt.grid(axis='y', alpha=0.75)

    # Save the plot to the output file
    plt.tight_layout()
    plt.savefig(output_file, format="png")
    print(f"Plot saved as {output_file}")

if __name__ == "__main__":
    main()
