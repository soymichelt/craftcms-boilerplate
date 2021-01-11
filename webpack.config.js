const path = require('path');
const BrowserSyncPlugin = require('browser-sync-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
    entry: './src/index.ts',
    output: {
        filename: 'app.js',
        path: path.resolve(__dirname, 'craft/web/dist'),
    },
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                use: 'ts-loader',
                exclude: /node_modules/,
            },
            {
                test: /\.(s*)css$/,
                use: [
                    { loader: MiniCssExtractPlugin.loader },
                    'css-loader',
                    'sass-loader',
                ],
            },
        ],
    },
    resolve: {
        extensions: ['.ts', '.tsx', '.js'],
    },
    plugins: [
        new BrowserSyncPlugin({
            host: 'localhost',
            port: 5700,
            proxy: 'http://localhost:5600'
        }, {
            reload: false,
        }),
        new MiniCssExtractPlugin({
            filename: path.resolve(__dirname, 'craft/web/dist/app.css'),
        }),
    ],
};