# Nextflow Basic Workflow Example

This Nextflow script demonstrates a simple data processing pipeline, illustrating Nextflow's core concepts for managing complex workflows. It defines two processes: one to split an input string into words and another to convert each word to uppercase. The workflow orchestrates these steps, showing how data flows between processes via channels, enabling parallel execution and result collection.

## Language

`nextflow`

## How to Run

1. Ensure Nextflow (https://www.nextflow.io/docs/latest/getstarted.html) and Java are installed on your system.
2. Save the code above as `main.nf`.
3. Run the workflow from your terminal: `nextflow run main.nf`
4. To provide a custom input string, use: `nextflow run main.nf --input_string "orange grape kiwi"`

## Original Article

This example accompanies the Turkish article: [Nextflow Nedir? Büyük Veri İş Akışlarının Kralı](https://fatihsoysal.com/blog/nextflow-nedir-buyuk-veri-is-akislarinin-krali/).

## License

MIT — see [LICENSE](LICENSE).
