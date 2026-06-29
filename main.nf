// Define parameters for the workflow
params.input_string = "apple banana cherry" // Default input string

// Process 1: SPLIT_STRING
// This Nextflow process takes the input string and splits it into individual words.
// Each 'process' defines a distinct computational step.
process SPLIT_STRING {
    output:
    // The 'output' block defines what this process emits. 'each val(word)' means
    // each word is emitted as a separate item on a channel, enabling parallelism.
    each val(word)

    script:
    // The 'script' block contains the commands to be executed (typically Bash).
    // Here, it splits the input string by spaces into newlines.
    """
echo "${params.input_string}" | tr ' ' '\n'
    """
}

// Process 2: UPPERCASE_ITEM
// This process takes a single word and converts it to uppercase.
// Nextflow will automatically run this process for each item received from its input channel,
// potentially in parallel across different compute resources.
process UPPERCASE_ITEM {
    input:
    // The 'input' block defines what this process expects to receive.
    // 'val word' indicates it takes a single value (a word) from an upstream channel.
    val word

    output:
    // It outputs the uppercase version of the word.
    val(uppercase_word)

    script:
    // Converts the input word to uppercase using Bash's built-in functionality.
    """
echo "${word.toUpperCase()}"
    """
}

// Define the main workflow
// The 'workflow' block orchestrates how processes are connected and executed.
workflow {
    // Step 1: Call SPLIT_STRING process.
    // The output of SPLIT_STRING (individual words) is captured into a channel named 'split_words_channel'.
    split_words_channel = SPLIT_STRING()

    // Step 2: Call UPPERCASE_ITEM process for each word in the 'split_words_channel'.
    // Nextflow automatically handles iterating over the channel and running
    // UPPERCASE_ITEM for each item, managing dependencies and parallelism.
    uppercase_words_channel = UPPERCASE_ITEM(split_words_channel)

    // Step 3: Observe intermediate results.
    // The 'view' operator allows inspecting channel contents as they pass through the workflow.
    // This will print each uppercase word as it's produced by UPPERCASE_ITEM.
    uppercase_words_channel.view { item -> "Processed word: $item" }

    // Step 4: Collect all results into a single list and print the final collection.
    // The 'collect()' operator gathers all items from a channel into a single list
    // once all upstream processes have completed. This demonstrates aggregation.
    uppercase_words_channel.collect().view { list -> "Final collected list: $list" }
}
